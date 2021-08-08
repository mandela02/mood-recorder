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

    private lazy var inputUseCase = InputUseCase(repository: inputRepository)

    private init() {}
    
    func getinputUseCase() -> InputUseCase {
        return inputUseCase
    }
}
