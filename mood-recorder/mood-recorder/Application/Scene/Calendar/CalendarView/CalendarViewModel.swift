//
//  CalendarViewModel.swift
//  CalendarViewModel
//
//  Created by TriBQ on 8/19/21.
//

import Foundation
import Combine

class CalendarViewModel: ViewModel {
    
    @Published
    var state: CalendarState
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase = UseCaseProvider.defaultProvider.getCalendarUseCases()

    init(state: CalendarState) {
        self.state = state
        setupSubcription()
    }
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    func trigger(_ input: CalendarTrigger) {
        switch input {
        case .reload:
            syncFetch()
        case .dateSelection(let model):
            state.selectedDiaryDataModel = model
            if model.date.isInTheFuture {
                state.isDetailViewShowing = false
            } else {
                if model.sections.isEmpty {
                    state.isDetailViewShowing = false
                } else {
                    state.isDetailViewShowing = true
                }
            }
        case .deselectDate:
            state.selectedDiaryDataModel = nil
            state.isDetailViewShowing = false
        case .goToNextMonth:
            state.currentMonth.month += 1
            if state.currentMonth.month == 13 {
                state.currentMonth = (1, state.currentMonth.year + 1)
            }
            self.state.dates = createCalendarDates()
        case .backToLaseMonth:
            state.currentMonth.month -= 1
            if state.currentMonth.month == 0 {
                state.currentMonth = (12, state.currentMonth.year - 1)
            }
            self.state.dates = createCalendarDates()
        case .goTo(month: let month, year: let year):
            state.currentMonth = (month, year)
            self.state.dates = createCalendarDates()
        case .goToToDay:
            state.currentMonth = (Date().month, Date().year)
            self.state.dates = createCalendarDates()
        case .handleFutureDialog(status: let status):
            state.isFutureWarningDialogShow = status == .open
        case .handelDatePickerView(status: let status):
            state.isDatePickerShow = status == .open
        case .handelDeleteDialog(status: _):
            // state.isDeleteDialogShowing = status == .open
            guard let date = state.selectedDiaryDataModel?.date else { return }
            let response = useCase.delete(at: date.startOfDayInterval)
            Task {
                await fetch(responses: response)
            }
        case .handelImageSharingView(status: let status):
            state.isShareImageViewShowing = status == .open
        }
    }
        
    private func syncFetch() {
        guard let start = state.dates.first?.startOfDayInterval,
              let end = state.dates.last?.endOfDayInterval else { return }

        let response = useCase.fetch(from: start, to: end)

        Task {
            await fetch(responses: response)
        }
    }
            
    private func setupSubcription() {
        self.useCase.publisher()
            .sink { [weak self] in
                guard let self = self else { return }
                self.syncFetch()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Async Function
extension CalendarViewModel {
    private func fetch(responses: DatabaseResponse...) async {
        if responses.count != 1 { return }

        do {
            let result = try await handleResponse(response: responses[0])
            if let result = result as? [DiaryDataModel] {
                await handleData(models: result)
            } else {
                syncFetch()
            }
        } catch let error {
            print(error)
        }
        
    }

    private func handleResponse(response: DatabaseResponse) async throws -> Any? {
        switch response {
        case .success(data: let data):
            if let data = data {
                return data
            }
            return nil
        case .error(error: let error):
            throw error
        }
    }
    
    private func handleData(models: [DiaryDataModel]) async {
        let result = Task(priority: .background) { () -> [DiaryDataModel] in
            
            var diaries = state.dates.map { DiaryDataModel(date: $0, sections: []) }
            
            for index in diaries.indices {
                guard let model = models
                        .first(where: {$0.date.startOfDayInterval ==
                            diaries[index].date.startOfDayInterval})
                else { continue }
                diaries[index].sections = model.sections
            }
            
            return diaries
        }
        
        let diaries = await result.value
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.state.isDetailViewShowing = false
            self.state.diaries = diaries
            
            guard let date = self.state.selectedDiaryDataModel?.date else { return }
            
            self.state.selectedDiaryDataModel = diaries
                .first(where: {$0.date.isInSameDay(as: date)})
            
            if !(self.state.selectedDiaryDataModel?.sections.isEmpty ?? true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.state.isDetailViewShowing = true
                }
            }
        }
    }
    
    private func createCalendarDates(month: Int? = nil,
                                     year: Int? = nil) -> [Date] {
        let thisMonthDate = Date(year: year ?? state.currentMonth.year,
                                 month: month ?? state.currentMonth.month)
        return thisMonthDate.getAllDateInMonthFaster()
    }
}

// MARK: - Custom Type
extension CalendarViewModel {
    enum ViewStatus {
        case open
        case close
    }
    
    struct CalendarState {
        var dates: [Date] = []
        var selectedDiaryDataModel: DiaryDataModel?
        var currentMonth = (month: Date().month, year: Date().year)
        var diaries: [DiaryDataModel] = []
        
        var isDetailViewShowing = false
        var isDeleteDialogShowing = false
        var isFutureWarningDialogShow = false
        var isShareImageViewShowing = false
        var isDatePickerShow = false
    }
    
    enum CalendarTrigger {
        case dateSelection(model: DiaryDataModel)
        case deselectDate
        case goTo(month: Int, year: Int)
        case goToNextMonth
        case goToToDay
        case backToLaseMonth
        case reload
        
        case handleFutureDialog(status: ViewStatus)
        case handelDatePickerView(status: ViewStatus)
        case handelDeleteDialog(status: ViewStatus)
        case handelImageSharingView(status: ViewStatus)
    }
}
