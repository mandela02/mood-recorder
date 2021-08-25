//
//  OptionUseCase.swift
//  OptionUseCase
//
//  Created by TriBQ on 8/23/21.
//

import Foundation

protocol FetchOptionUseCaseType {
    func fetchAndConvert(from start: Double, to end: Double) -> DatabaseResponse
}

class FetchOptionUseCase: FetchOptionUseCaseType {
    private let repository: Repository<CDDiaryModel>

    init(repository: Repository<CDDiaryModel>) {
        self.repository = repository
    }
    
    func fetchAndConvert(from start: Double, to end: Double) -> DatabaseResponse {
        let result = repository
            .fetchRequest(predicate: NSPredicate(format: "date >= %lf AND date <= %lf",
                                                 start,
                                                 end))
        switch result {
        case .success(data: let model as [CDDiaryModel]):
            let allSections = model
                .compactMap({$0.clone().sections})
                .flatMap({$0})
            
            let allOptions = allSections
                .filter({$0.isVisible})
                .compactMap({$0.content})
                .compactMap({$0.options})
                .flatMap({$0})
            
            let filtedOptions = allOptions
                .filter({$0.isSelected &&
                    !$0.wrappedName.isEmpty &&
                    !$0.wrappedImage.isEmpty})
                .map({ImageAndTitleModel(image: AppImage.appImage(value: $0.wrappedImage),
                                         title: $0.wrappedName)})
            
            let group = Dictionary(grouping: filtedOptions, by: { $0 })
                
            let counts = group.map { (key, value) in
                return OptionCountModel(option: key, count: value.count)
            }

            return .success(data: counts)
        case .error(let error):
            return.error(error: error)
        default:
            return .error(error: NSError(domain: "Can not find this record",
                                         code: 1,
                                         userInfo: nil))
        }
    }
}
