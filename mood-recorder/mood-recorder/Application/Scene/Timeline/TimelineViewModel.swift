//
//  TimelineViewModel.swift
//  TimelineViewModel
//
//  Created by TriBQ on 8/25/21.
//

import Foundation
import Combine

class TimelineViewModel: ViewModel {
    @Published
    var state: TimelineState
    
    private let useCase: TimelineUseCaseType
    private var cancellables = Set<AnyCancellable>()
    
    init(state: TimelineState, useCase: TimelineUseCaseType) {
        self.state = state
        self.useCase = useCase
        setupSubcription()
    }
    
    func trigger(_ input: TimelineTrigger) {
        switch input {
        case .onDeleteDiary(let diary):
            let response = useCase.delete(at: diary.date.startOfDayInterval)
            Task {
                await fetch(responses: response)
            }
        case .onEditDiary(let diary):
            print(diary)
        case .reload:
            syncFetch()
        case .goToNextMonth:
            state.currentMonth.month += 1
            if state.currentMonth.month == 13 {
                state.currentMonth = (1, state.currentMonth.year + 1)
            }
        case .backToLaseMonth:
            state.currentMonth.month -= 1
            if state.currentMonth.month == 0 {
                state.currentMonth = (12, state.currentMonth.year - 1)
            }
        case .goTo(month: let month, year: let year):
            state.currentMonth = (month, year)
        case .goToToDay:
            state.currentMonth = (Date().month, Date().year)
        case .handelDatePickerView(status: let status):
            state.isDatePickerShow = status == .open
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

extension TimelineViewModel {
    private func syncFetch() {        
        let start = state.dates.start.startOfDayInterval
        let end = state.dates.end.endOfDayInterval

        let response = useCase.fetch(from: start, to: end)

        Task {
            await fetch(responses: response)
        }
    }

    private func fetch(responses: DatabaseResponse...) async {
        if responses.count != 1 { return }

        do {
            let result = try await handleResponse(response: responses[0])
            if let result = result as? [DiaryDataModel] {
                await handleData(models: result)
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
        let result = Task { () -> [DiaryDataModel] in
            return models.sorted(by: {$0.date < $1.date})
        }
        
        let diaries = await result.value
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.state.diaries = diaries
        }
    }
}

extension TimelineViewModel {
    enum ViewStatus {
        case open
        case close
    }

    struct TimelineState {
        var diaries: [DiaryDataModel] = []
        
        var currentMonth = (month: Date().month, year: Date().year)
        var isDatePickerShow = false

        var dates: (start: Date, end: Date) {
            let ref = Date(year: currentMonth.year, month: currentMonth.month)
            return (ref.startOfMonth, ref.endOfMonth)
        }
        
        var lastDiary: DiaryDataModel {
            return diaries.last ?? DiaryDataModel(date: Date(), sections: [])
        }
    }
    
    enum TimelineTrigger {
        case onDeleteDiary(diary: DiaryDataModel)
        case onEditDiary(diary: DiaryDataModel)
        case reload
        case goTo(month: Int, year: Int)
        case goToNextMonth
        case goToToDay
        case backToLaseMonth
        case handelDatePickerView(status: ViewStatus)
    }
}
