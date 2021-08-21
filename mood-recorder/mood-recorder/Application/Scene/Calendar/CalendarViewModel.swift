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
            } else {
                if model.sections.isEmpty {
                    state.isInputViewShowing = true
                } else {
                    state.isDetailViewShowing = false
                }
            }
        case .deselectDate:
            state.selectedDate = nil
        case .goToNextMonth:
            state.currentMonth.month += 1
            if state.currentMonth.month == 13 {
                state.currentMonth = (1, state.currentMonth.year + 1)
            }
            createCalendarDates()
            fetch()
        case .backToLaseMonth:
            state.currentMonth.month -= 1
            if state.currentMonth.month == 0 {
                state.currentMonth = (12, state.currentMonth.year - 1)
            }
            createCalendarDates()
            fetch()
        case .showDatePicker:
            state.isDatePickerShow = true
        case .closeDatePicker:
            state.isDatePickerShow = false
        case .goTo(month: let month, year: let year):
            state.currentMonth = (month, year)
            createCalendarDates()
            fetch()
        case .goToToDay:
            loadToday()
        case .share:
            print("share")
        case .closeFutureDialog:
            state.isFutureWarningDialogShow = false
        case .closeInputView:
            state.isInputViewShowing = false
        case .reload:
            fetch()
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
    
    private func fetch() {
        guard let start = state.dates.first?.startOfDayInterval,
              let end = state.dates.last?.startOfDayInterval else { return }
        
        let result = useCase.fetch(from: start, to: end)
        
        state.response.send(result)
    }
    
    private func loadToday() {
        state.currentMonth = (Date().month, Date().year)
        state.selectedDate = state.diaries.first(where: {$0.date.isInSameDay(as: Date())})
        createCalendarDates()
        fetch()
        if !(state.selectedDate?.sections.isEmpty ?? true) {
            state.isDetailViewShowing = true
        }
    }
    
    private func setupSubcription() {
        self.state.response
            .sink { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(data: let data):
                    if let models = data as? [InputDataModel] {
                        var diaries = self.state.dates.map { InputDataModel(date: $0, sections: []) }
                        
                        for index in diaries.indices {
                            guard let model = models.first(where: {$0.date.startOfDayInterval == diaries[index].date.startOfDayInterval})
                            else { continue }
                            diaries[index].sections = model.sections
                        }
                        
                        self.state.diaries = diaries
                    }
                case .error(error: let error):
                    self.state.diaries = self.state.dates.map { InputDataModel(date: $0, sections: []) }
                    print(error)
                }
                
            }
            .store(in: &cancellables)
    }
}

extension CalendarViewModel {
    struct CalendarState {
        var dates: [Date] = []
        var selectedDate: InputDataModel?
        var currentMonth = (month: Date().month, year: Date().year)
        var isDatePickerShow = false
        var isFutureWarningDialogShow = false
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
        case reload
    }
}
