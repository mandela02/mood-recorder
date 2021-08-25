//
//  UseCaseProvider.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

class UseCaseProvider {
    static let defaultProvider = UseCaseProvider()

    private lazy var inputRepository = Repository<CDInputModel>()

    private lazy var diaryUseCases = DiaryUseCases(repository: inputRepository)
    private lazy var calendarUseCases = CalendarUseCases(repository: inputRepository)
    private lazy var chartUseCases = ChartUseCases(repository: inputRepository)
    
    private init() {}

    func getDiaryUseCases() -> DiaryUseCaseType {
        return diaryUseCases
    }

    func getCalendarUseCases() -> CalendarUseCaseType {
        return calendarUseCases
    }
    
    func getChartUseCases() -> ChartUseCaseType {
        return chartUseCases
    }
}
