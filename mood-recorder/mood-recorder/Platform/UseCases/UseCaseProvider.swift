//
//  UseCaseProvider.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

class UseCaseProvider {
    static let defaultProvider = UseCaseProvider()

    private lazy var diaryRepository = Repository<CDDiaryModel>()

    private lazy var diaryUseCases = DiaryUseCases(repository: diaryRepository)
    private lazy var calendarUseCases = CalendarUseCases(repository: diaryRepository)
    private lazy var chartUseCases = ChartUseCases(repository: diaryRepository)
    
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
