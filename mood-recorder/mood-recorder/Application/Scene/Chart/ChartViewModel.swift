//
//  ChartViewModel.swift
//  ChartViewModel
//
//  Created by TriBQ on 8/22/21.
//

import Foundation
import Combine

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
        Task {
            await fetch()
        }
        setupSubcription()
    }
    
    func trigger(_ input: ChartTrigger) {
        switch input {
        case .goTo(let month, let year):
            print("goto \(month), \(year)")
        }
    }
    
    private func setupSubcription() {
        self.useCase.publisher()
            .sink { [weak self] in
                guard let self = self else { return }
                Task {
                    await self.fetch()
                }
            }
            .store(in: &cancellables)
    }
}

extension ChartViewModel {
    private func fetch() async {
        let response = useCase.fetch(from: state.currentMonthDate.startOfMonth.startOfDayInterval,
                                     to: state.currentMonthDate.endOfMonth.endOfDayInterval)
        await handleResponse(response: response)
    }

    private func handleResponse(response: DatabaseResponse) async {
        switch response {
        case .success(data: let data):
            if let models = data as? [InputDataModel] {
                await self.handleData(models: models)
            }
        case .error(error: let error):
            print(error)
        }
    }

    private func handleData(models: [InputDataModel]) async {
        let result = Task(priority: .background) { () -> (diaries: [InputDataModel],
                                                          chartDatas: [ChartData]) in
            var diaries = state.currentMonthDate
                .getDateMonth()
                .map { InputDataModel(date: $0,
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
            self.state.chartDatas = waitResult.chartDatas
        }
    }
}

extension ChartViewModel {
    struct ChartState {
        var currentMonth = (month: Date().month, year: Date().year)
        var diaries: [InputDataModel] = []
        var chartDatas: [ChartData] = []

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
    
    enum ChartTrigger {
        case goTo(month: Int, year: Int)
    }
}
