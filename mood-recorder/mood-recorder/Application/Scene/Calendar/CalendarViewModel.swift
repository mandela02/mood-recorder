//
//  CalendarViewModel.swift
//  CalendarViewModel
//
//  Created by TriBQ on 8/19/21.
//

import Foundation
import Combine

class CalendarViewModel: ViewModel {
    
    @Published var state: CalendarState
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase = UseCaseProvider.defaultProvider.getCalendarUseCases()

    init(state: CalendarState) {
        self.state = state
        setupSubcription()
        loadToday()
    }
    
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    func trigger(_ input: CalendarTrigger) {
        switch input {
        case .dateSelection(let model):
            state.selectedInputDataModel = model
            if model.date.isInTheFuture {
                state.isFutureWarningDialogShow = true
                state.isDetailViewShowing = false
                state.isInputViewShowing = false
            } else {
                if model.sections.isEmpty {
                    state.isDetailViewShowing = false
                    state.isInputViewShowing = true
                } else {
                    state.isDetailViewShowing = true
                }
            }
        case .deselectDate:
            state.selectedInputDataModel = nil
            state.isDetailViewShowing = false
        case .goToNextMonth:
            state.currentMonth.month += 1
            if state.currentMonth.month == 13 {
                state.currentMonth = (1, state.currentMonth.year + 1)
            }
            syncFetch()
        case .backToLaseMonth:
            state.currentMonth.month -= 1
            if state.currentMonth.month == 0 {
                state.currentMonth = (12, state.currentMonth.year - 1)
            }
            syncFetch()
        case .showDatePicker:
            state.isDatePickerShow = true
        case .closeDatePicker:
            state.isDatePickerShow = false
        case .goTo(month: let month, year: let year):
            state.currentMonth = (month, year)
            syncFetch()
        case .goToToDay:
            loadToday()
        case .share:
            state.isShareImageViewShowing = true
        case .closeFutureDialog:
            state.isFutureWarningDialogShow = false
        case .closeInputView:
            state.isInputViewShowing = false
        case .edit:
            state.isInputViewShowing = true
        case .delete:
            guard let date = state.selectedInputDataModel?.date else { return }
            Task {
                await handleResponse(response: useCase.delete(at: date.startOfDayInterval),
                                     datesInMonth: self.state.dates)
            }
            
            state.isDetailViewShowing = false
        }
    }
        
    private func syncFetch() {
        self.state.dates = createCalendarDates()
        Task {
            await fetch(dates: state.dates)
        }
    }
    
    private func loadToday() {
        Task {
            await loadData(date: Date())
        }
    }
        
    private func setupSubcription() {
        self.useCase.publisher()
            .sink { [weak self] in
                guard let self = self else { return }
                Task {
                    await self.loadData(date: self.state.selectedInputDataModel?.date ?? Date())
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Async Function
extension CalendarViewModel {
    private func fetch(dates: [Date]) async {
        guard let start = dates.first?.startOfDayInterval,
              let end = dates.last?.startOfDayInterval else { return }
        
        let response = useCase.fetch(from: start, to: end)
        
        await handleResponse(response: response, datesInMonth: dates)
    }

    private func handleResponse(response: DatabaseResponse,
                                datesInMonth: [Date]) async {
        switch response {
        case .success(data: let data):
            if let models = data as? [InputDataModel] {
                await self.handleData(models: models, dates: datesInMonth)
            }
        case .error(error: let error):
            print(error)
        }
    }
    
    private func handleData(models: [InputDataModel], dates: [Date]) async {
        let result = Task(priority: .background) { () -> [InputDataModel] in
            
            var diaries = dates.map { InputDataModel(date: $0,
                                                                sections: []) }
            
            for index in diaries.indices {
                guard let model = models.first(where: {$0.date.startOfDayInterval == diaries[index].date.startOfDayInterval})
                else { continue }
                diaries[index].sections = model.sections
            }
            
            return diaries
        }
        
        let diaries = await result.value
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state.diaries = diaries
        }
    }
    
    private func loadData(date: Date) async {
        let dates = createCalendarDates(month: date.month, year: date.year)
        await fetch(dates: dates)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state.currentMonth = (date.month, date.year)
            self.state.dates = self.state.dates
            self.state.selectedInputDataModel = self.state.diaries.first(where: {$0.date.isInSameDay(as: date)})
            if !(self.state.selectedInputDataModel?.sections.isEmpty ?? true) {
                self.state.isDetailViewShowing = true
            }
        }
    }
    
    private func createCalendarDates(month: Int? = nil,
                                     year: Int? = nil) -> [Date] {
        var dateComponents = DateComponents()
        dateComponents.year = year ?? state.currentMonth.year
        dateComponents.month = month ?? state.currentMonth.month
        dateComponents.day = 1
        
        let calendar = Calendar.gregorian
        
        guard let thisMonthDate = calendar.date(from: dateComponents) else {
            return []
        }
        
        return thisMonthDate.getAllDateInMonthFaster()
    }
}

// MARK: - Custom Type
extension CalendarViewModel {
    struct CalendarState {
        var dates: [Date] = []
        var selectedInputDataModel: InputDataModel?
        var currentMonth = (month: Date().month, year: Date().year)
        var isDatePickerShow = false
        var isFutureWarningDialogShow = false
        var isShareImageViewShowing = false
        var diaries: [InputDataModel] = []
        
        var isDetailViewShowing = false
        var isInputViewShowing = false
    }
    
    enum CalendarTrigger {
        case dateSelection(model: InputDataModel)
        case deselectDate
        case goTo(month: Int, year: Int)
        case goToNextMonth
        case goToToDay
        case share
        case backToLaseMonth
        case showDatePicker
        case closeDatePicker
        case closeFutureDialog
        case closeInputView
        case edit
        case delete
    }
}
