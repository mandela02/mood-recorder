//
//  ChartUseCases.swift
//  ChartUseCases
//
//  Created by TriBQ on 8/22/21.
//

import Foundation
import Combine

protocol ChartUseCaseType {
    func fetch(from start: Double, to end: Double) -> DatabaseResponse
    func publisher() -> AnyPublisher<Void, Never>
}

struct ChartUseCases: ChartUseCaseType {
    private let repository: Repository<CDInputModel>
    private let fetchUseCase: FetchUseCaseType

    init(repository: Repository<CDInputModel>) {
        self.repository = repository
        self.fetchUseCase = FetchUseCase(repository: repository)
    }
    
    func fetch(from start: Double, to end: Double) -> DatabaseResponse {
        return fetchUseCase.fetchAndConvert(from: start, to: end)
    }
    
    func publisher() -> AnyPublisher<Void, Never> {
        return repository.publisher()
    }
}