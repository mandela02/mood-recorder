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
    private lazy var fetchUseCase = FetchDiaryUseCase(repository: diaryRepository)
    private lazy var optionUseCase = FetchOptionUseCase(repository: diaryRepository)

    private lazy var diaryUseCases = DiaryUseCases(repository: diaryRepository,
                                                   fetchUseCase: fetchUseCase)
    private lazy var calendarUseCases = CalendarUseCases(repository: diaryRepository,
                                                         fetchUseCase: fetchUseCase)
    private lazy var chartUseCases = ChartUseCases(repository: diaryRepository,
                                                   fetchUseCase: fetchUseCase,
                                                   optionUseCase: optionUseCase)
    private lazy var timelineUseCases = TimelineUseCases(repository: diaryRepository,
                                                         fetchUseCase: fetchUseCase)

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
    
    func getTimelineUseCase() -> TimelineUseCaseType {
        return timelineUseCases
    }
}
