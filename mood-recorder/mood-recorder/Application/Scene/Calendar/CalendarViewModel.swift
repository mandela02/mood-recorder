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
            state.selectedDate = model
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
            state.selectedDate = nil
            state.isDetailViewShowing = false
        case .goToNextMonth:
            state.currentMonth.month += 1
            if state.currentMonth.month == 13 {
                state.currentMonth = (1, state.currentMonth.year + 1)
            }
            createCalendarDates()
            syncFetch()
        case .backToLaseMonth:
            state.currentMonth.month -= 1
            if state.currentMonth.month == 0 {
                state.currentMonth = (12, state.currentMonth.year - 1)
            }
            createCalendarDates()
            syncFetch()
        case .showDatePicker:
            state.isDatePickerShow = true
        case .closeDatePicker:
            state.isDatePickerShow = false
        case .goTo(month: let month, year: let year):
            state.currentMonth = (month, year)
            createCalendarDates()
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
            guard let date = state.selectedDate?.date else { return }
            state.response.send(useCase.delete(at: date.startOfDayInterval))
            state.isDetailViewShowing = false
        }
    }
    
    private func createCalendarDates() {
        var dateComponents = DateComponents()
        dateComponents.year = state.currentMonth.year
        dateComponents.month = state.currentMonth.month
        dateComponents.day = 1
        
        let calendar = Calendar.gregorian
        
        guard let thisMonthDate = calendar.date(from: dateComponents) else {
            return
        }
        
        self.state.dates = thisMonthDate.getAllDateInMonthFaster()
    }
    
    private func syncFetch() {
        Task {
            await fetch()
        }
    }
    
    private func loadToday() {
        Task {
            await loadData(date: Date())
        }
    }
    
    private func fetch() async {
        guard let start = state.dates.first?.startOfDayInterval,
              let end = state.dates.last?.startOfDayInterval else { return }
        
        let response = useCase.fetch(from: start, to: end)
        
        switch response {
        case .success(data: let data):
            if let models = data as? [InputDataModel] {
                await self.handleData(models: models)
            }
        case .error(error: let error):
            self.state.diaries = self.state.dates.map { InputDataModel(date: $0, sections: []) }
            print(error)
        }
    }
        
    private func loadData(date: Date) async {
        state.currentMonth = (date.month, date.year)
        createCalendarDates()
        await fetch()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state.selectedDate = self.state.diaries.first(where: {$0.date.isInSameDay(as: date)})
            if !(self.state.selectedDate?.sections.isEmpty ?? true) {
                self.state.isDetailViewShowing = true
            }
        }
    }
    
    private func setupSubcription() {
        self.useCase.publisher()
            .sink { [weak self] in
                guard let self = self else { return }
                Task {
                    await self.loadData(date: self.state.selectedDate?.date ?? Date())
                }
            }
            .store(in: &cancellables)
    }
    
    private func handleData(models: [InputDataModel]) async {
        let result = Task(priority: .background) { () -> [InputDataModel] in
            var diaries = self.state.dates.map { InputDataModel(date: $0,
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
}

extension CalendarViewModel {
    struct CalendarState {
        var dates: [Date] = []
        var selectedDate: InputDataModel?
        var currentMonth = (month: Date().month, year: Date().year)
        var isDatePickerShow = false
        var isFutureWarningDialogShow = false
        var isShareImageViewShowing = false
        var diaries: [InputDataModel] = []
        
        var isDetailViewShowing = false
        var isInputViewShowing = false
        
        let response = PassthroughSubject<DatabaseResponse, Never>()
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
