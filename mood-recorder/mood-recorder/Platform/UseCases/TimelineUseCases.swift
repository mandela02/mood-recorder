//
//  TimelineUseCases.swift
//  TimelineUseCases
//
//  Created by TriBQ on 8/26/21.
//

import Foundation
import Combine

protocol TimelineUseCaseType {
    func fetch(from start: Double, to end: Double) -> DatabaseResponse
    func delete(at date: Double) -> DatabaseResponse
    func publisher() -> AnyPublisher<Void, Never>
}

struct TimelineUseCases: TimelineUseCaseType {
    private let repository: Repository<CDDiaryModel>
    private let fetchUseCase: FetchDiaryUseCaseType
    
    init(repository: Repository<CDDiaryModel>, fetchUseCase: FetchDiaryUseCaseType) {
        self.repository = repository
        self.fetchUseCase = fetchUseCase
    }
    
    func fetch(from start: Double, to end: Double) -> DatabaseResponse {
        return fetchUseCase.fetchAndConvert(from: start, to: end)
    }
    
    func delete(at date: Double) -> DatabaseResponse {
        let result = fetchUseCase.fetch(at: date)
        switch result {
        case .success(data: let model as CDDiaryModel):
            return repository.delete(model: model)
        case .error(let error):
            return.error(error: error)
        default:
            return .error(error: NSError(domain: "Error when delete",
                                         code: 2,
                                         userInfo: nil))
        }
    }
    
    func publisher() -> AnyPublisher<Void, Never> {
        return repository.publisher()
    }
}
