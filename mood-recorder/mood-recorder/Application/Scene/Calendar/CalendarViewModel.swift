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
    
    init(state: CalendarState) {
        self.state = state
        createCalendarDates()
    }
    
    func trigger(_ input: CalendarTrigger) {
        switch input {
        case .dateSelection(let date):
            state.selectedDate = date
            if date.isInTheFuture {
                state.isFutureWarningDialogShow = true
            }
        case .deselectDate:
            state.selectedDate = nil
        case .goToNextMonth:
            state.currentMonth.month += 1
            if state.currentMonth.month == 13 {
                state.currentMonth = (1, state.currentMonth.year + 1)
            }
            createCalendarDates()
        case .backToLaseMonth:
            state.currentMonth.month -= 1
            if state.currentMonth.month == 0 {
                state.currentMonth = (12, state.currentMonth.year - 1)
            }
            createCalendarDates()
        case .showDatePicker:
            state.isDatePickerShow = true
        case .closeDatePicker:
            state.isDatePickerShow = false
        case .goTo(month: let month, year: let year):
            state.currentMonth = (month, year)
            createCalendarDates()
        case .goToToDay:
            state.currentMonth = (Date().month, Date().year)
            createCalendarDates()
        case .share:
            print("share")
        case .closeFutureDialog:
            state.isFutureWarningDialogShow = false
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
}

extension CalendarViewModel {
    struct CalendarState {
        var dates: [Date] = []
        var selectedDate: Date?
        var currentMonth = (month: Date().month, year: Date().year)
        var isDatePickerShow = false
        var isFutureWarningDialogShow = false
    }
    
    enum CalendarTrigger {
        case dateSelection(date: Date)
        case deselectDate
        case goTo(month: Int, year: Int)
        case goToNextMonth
        case goToToDay
        case share
        case backToLaseMonth
        case showDatePicker
        case closeDatePicker
        case closeFutureDialog
    }
}
