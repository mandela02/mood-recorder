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

    private lazy var inputUseCases = InputUseCases(repository: inputRepository)
    private lazy var calendarUseCases = CalendarUseCases(repository: inputRepository)

    private init() {}
    
    func getInputUseCases() -> InputUseCaseType {
        return inputUseCases
    }
    
    func getCalendarUseCases() -> CalendarUseCaseType {
        return calendarUseCases
    }
}
