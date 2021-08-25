//
//  ChartViewModel.swift
//  ChartViewModel
//
//  Created by TriBQ on 8/22/21.
//

import Foundation
import Combine
import SwiftUI

class ChartViewModel: ViewModel {
    @Published
    var state: ChartState
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase = UseCaseProvider.defaultProvider.getChartUseCases()
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    init(state: ChartState) {
        self.state = state
        setupSubcription()
    }
    
    func trigger(_ input: ChartTrigger) {
        switch input {
        case .reload:
            syncFetch()
        case .goTo(let month, let year):
            state.currentMonth = (month, year)
        case .goToNextMonth:
            state.currentMonth.month += 1
            if state.currentMonth.month == 13 {
                state.currentMonth = (1, state.currentMonth.year + 1)
            }
        case .goToLastMonth:
            state.currentMonth.month -= 1
            if state.currentMonth.month == 0 {
                state.currentMonth = (12, state.currentMonth.year - 1)
            }
        case .handleDatePickerViewStatus(status: let status):
            state.isDatePickerShowing = status == .open
        case .handleChartViewStatus(status: let status):
            switch status {
            case .close:
                state.chartShowPercent = 0
            case .open:
                var duration: Double = 0
                let number = state.coreEmotionChartDatas.count
                
                if number < 5 {
                    duration = 0.5
                } else if duration < 15 {
                    duration = 1
                } else if duration < 25 {
                    duration = 1.5
                } else {
                    duration = 2
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    withAnimation(Animation.linear(duration: duration)) {
                        self?.state.chartShowPercent = 1
                    }
                }
            }
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
    
    private func syncFetch() {
        let start = state.currentMonthDate.startOfMonth.startOfDayInterval
        let end = state.currentMonthDate.endOfMonth.endOfDayInterval
        
        let fetchDiaryResponse = useCase.fetch(from: start, to: end)
        
        let fetchThisMonthOptionResponse = useCase.fetchAndCountOption(from: start, to: end)
        
        let lastMonthStart = state.currentMonthDate.previousMonth.startOfMonth.startOfDayInterval
        let lastMonthEnd = state.currentMonthDate.previousMonth.endOfMonth.startOfDayInterval
        
        let fetchLastMonthOptionResponse = useCase.fetchAndCountOption(from: lastMonthStart,
                                                                       to: lastMonthEnd)
        
        Task {
            await fetch(responses: fetchDiaryResponse,
                        fetchThisMonthOptionResponse,
                        fetchLastMonthOptionResponse)
        }
    }
}

extension ChartViewModel {
    private func fetch(responses: DatabaseResponse...) async {
    
        if responses.count != 3 { return }
        
        let fetchDiaryResponse = responses[0]
        let fetchThisMonthOptionResponse = responses[1]
        let fetchLastMonthOptionResponse = responses[2]

        do {
            async let fetchResult = handleResponse(response: fetchDiaryResponse)
            async let thisMonthOptionResult = handleResponse(response: fetchThisMonthOptionResponse)
            async let lastMonthOptionResult = handleResponse(response: fetchLastMonthOptionResponse)
            
            let results =  await [try fetchResult,
                                  try thisMonthOptionResult,
                                  try lastMonthOptionResult]
            
            var thisMonthData: [OptionCountModel] = []
            var lastMonthData: [OptionCountModel] = []
            var thisMonthDiaryDataModel: [DiaryDataModel] = []
            
            for (index, result) in results.enumerated() {
                switch result {
                case let result as [DiaryDataModel]:
                    if index == 0 {
                        thisMonthDiaryDataModel = result
                    }
                case let result as [OptionCountModel]:
                    if index == 1 {
                        thisMonthData = result
                    } else if index == 2 {
                        lastMonthData = result
                    }
                default:
                    continue
                }
            }
            
            await handleChartData(models: thisMonthDiaryDataModel)
            await generateStatisticalData(thisMonthData: thisMonthData, lastMonthData: lastMonthData)
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
    
    private func generateStatisticalData(thisMonthData: [OptionCountModel],
                                         lastMonthData: [OptionCountModel]) async {
        
        let task = Task(priority: .userInitiated) { () -> [OptionCountModel] in
            var overralResult: [OptionCountModel] = []
            
            if thisMonthData.isEmpty {
                return []
            }
            
            for data in thisMonthData {
                guard let lastMonth = lastMonthData.first(where: {$0.option == data.option}) else {
                    overralResult.append(OptionCountModel(option: data.option,
                                                          count: 0))
                    continue
                }
                
                overralResult.append(OptionCountModel(option: data.option,
                                                      count: data.count - lastMonth.count))
            }
            
            return overralResult.sorted(by: {$0.count > $1.count})
        }
        
        let result = await task.value
        
        DispatchQueue.main.async { [weak self] in
            self?.state.optionStatisticalDatas = result
        }
    
    }
    
    private func handleChartData(models: [DiaryDataModel]) async {
        let result = Task(priority: .background) { () -> (diaries: [DiaryDataModel],
                                                          chartDatas: [ChartData]) in
            var diaries = state.currentMonthDate
                .getDateMonth()
                .map { DiaryDataModel(date: $0,
                                      sections: []) }
            
            var chartDatas: [ChartData]  = []
            
            for index in diaries.indices {
                guard let model = models
                        .first(where: {$0.date.startOfDayInterval ==
                            diaries[index].date.startOfDayInterval})
                else { continue }
                diaries[index].sections = model.sections
                
                if diaries[index].isHavingData {
                    chartDatas.append(ChartData(emotion: diaries[index].emotion ?? .neutral,
                                                index: index))
                }
            }
            
            return (diaries, chartDatas)
        }
        
        let waitResult = await result.value
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state.diaries = waitResult.diaries
            self.state.coreEmotionChartDatas = waitResult.chartDatas
        }
    }
}

extension ChartViewModel {
    struct ChartState {
        var currentMonth = (month: Date().month, year: Date().year)
        var diaries: [DiaryDataModel] = []
        
        var coreEmotionChartDatas: [ChartData] = []
        var optionStatisticalDatas: [OptionCountModel] = []
        
        var isDatePickerShowing = false
        
        var chartShowPercent: Double = 0
        
        var currentMonthDate: Date {
            var dateComponents = DateComponents()
            dateComponents.year = currentMonth.year
            dateComponents.month = currentMonth.month
            dateComponents.day = 1
            
            let calendar = Calendar.gregorian
            
            guard let thisMonthDate = calendar.date(from: dateComponents) else {
                return Date()
            }
            
            return thisMonthDate
        }
    }
    
    enum SubViewStatus {
        case open
        case close
    }
    
    enum ChartTrigger {
        case goTo(month: Int, year: Int)
        case goToNextMonth
        case goToLastMonth
        case handleDatePickerViewStatus(status: SubViewStatus)
        case handleChartViewStatus(status: SubViewStatus)
        case reload
    }
}
