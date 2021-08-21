//
//  CalendarUseCases.swift
//  CalendarUseCases
//
//  Created by TriBQ on 8/21/21.
//

import Foundation
import Combine

protocol CalendarUseCaseType {
    func fetch(from start: Double, to end: Double) -> DatabaseResponse
    func delete(at date: Double) -> DatabaseResponse
    func publisher() -> AnyPublisher<Void, Never>
}

struct CalendarUseCases: CalendarUseCaseType {
    private let repository: Repository<CDInputModel>
    private let fetchUseCase: FetchUseCaseType
    
    init(repository: Repository<CDInputModel>) {
        self.repository = repository
        self.fetchUseCase = FetchUseCase(repository: repository)
    }
    
    func fetch(from start: Double, to end: Double) -> DatabaseResponse {
        let result = fetchUseCase.fetch(from: start, to: end)
        switch result {
        case .success(data: let models as [CDInputModel]):
            let inputDataModels = models.map { fetchUseCase.convert(model: $0) }
            return .success(data: inputDataModels)
        case .error(let error):
            return.error(error: error)
        default:
            return .error(error: NSError(domain: "Can not find data this month",
                                         code: 1,
                                         userInfo: nil))
        }
    }
    
    func delete(at date: Double) -> DatabaseResponse {
        let result = fetchUseCase.fetch(at: date)
        switch result {
        case .success(data: let model as CDInputModel):
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
