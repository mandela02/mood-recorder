//
//  FetchDiaryUseCase.swift
//  FetchDiaryUseCase
//
//  Created by TriBQ on 8/21/21.
//

import Foundation

protocol FetchDiaryUseCaseType {
    func fetch(at date: Double) -> DatabaseResponse
    func fetchAndConvert(at date: Double) -> DatabaseResponse
    func fetch(from start: Double, to end: Double) -> DatabaseResponse
    func fetchAndConvert(from start: Double, to end: Double) -> DatabaseResponse
}

class FetchDiaryUseCase: FetchDiaryUseCaseType {
    private let repository: Repository<CDDiaryModel>

    init(repository: Repository<CDDiaryModel>) {
        self.repository = repository
    }
    
    func fetch(from start: Double, to end: Double) -> DatabaseResponse {
        return repository.fetchRequest(predicate: NSPredicate(format: "date >= %lf AND date <= %lf", start, end))
    }
    
    func fetch(at date: Double) -> DatabaseResponse {
        return repository.fetchRequestGetFirst(predicate: NSPredicate(format: "date == %lf", date))
    }
    
    func fetchAndConvert(at date: Double) -> DatabaseResponse {
        let result = fetch(at: date)
        switch result {
        case .success(data: let model as CDDiaryModel):
            return .success(data: convert(prototype: model))
        case .error(let error):
            return.error(error: error)
        default:
            return .error(error: NSError(domain: "Can not find this record",
                                         code: 1,
                                         userInfo: nil))
        }
    }
    
    func fetchAndConvert(from start: Double, to end: Double) -> DatabaseResponse {
        let result = fetch(from: start, to: end)
        switch result {
        case .success(data: let models as [CDDiaryModel]):
            let diaryDataModels = models.map { convert(prototype: $0) }
            return .success(data: diaryDataModels)
        case .error(let error):
            return.error(error: error)
        default:
            return .error(error: NSError(domain: "Can not find data this month",
                                         code: 1,
                                         userInfo: nil))
        }
    }

    private func convert(prototype: CDDiaryModel) -> DiaryDataModel {
        let model = prototype.clone()
        
        var sectionModels = [SectionModel]()
        
        for cdSection in model.sections {
            guard let content = cdSection.content else { continue }
            let section = SectionType.section(from: Int(cdSection.sectionID))
            
            switch section {
            case .emotion:
                sectionModels.append(SectionModel(section: section,
                                                  title: section.title,
                                                  cell: CoreEmotion(rawValue: Int(content.emotion)),
                                                  isVisible: cdSection.isVisible))
            case .note:
                sectionModels.append(SectionModel(section: section,
                                                  title: section.title,
                                                  cell: TextModel(text: content.text),
                                                  isVisible: cdSection.isVisible))
            case .photo:
                sectionModels.append(SectionModel(section: section,
                                                  title: section.title,
                                                  cell: ImageModel(data: content.image),
                                                  isVisible: cdSection.isVisible))
            case .sleep:
                sectionModels.append(SectionModel(section: section,
                                                  title: section.title,
                                                  cell: SleepSchelduleModel(bedTime: content.bedTime,
                                                                            wakeUpTime: content.wakeUpTime),
                                                  isVisible: cdSection.isVisible))
            default:
                let cdOptions = content.options
                var optionModels = [OptionModel]()
                
                for cdOption in cdOptions {
                    let content = ImageAndTitleModel(image: AppImage.appImage(value: cdOption.wrappedImage),
                                                     title: cdOption.wrappedName)
                    
                    var model = OptionModel(content: content,
                                            isSelected: cdOption.isSelected)
                    model.isVisible = cdOption.isVisible
                    optionModels.append(model)
                }
                
                if section == .emotion {
                    var trueModels = CoreEmotion
                        .allCases
                        .map {
                            OptionModel(content: ImageAndTitleModel(image: $0.imageName,
                                                                    title: ""))
                        }
                    
                    for index in trueModels.indices {
                        guard let model = optionModels.first(where: {$0.content == trueModels[index].content})
                        else { continue }
                        trueModels[index].isSelected = model.isSelected
                    }
                    
                    optionModels = trueModels
                } else {
                    optionModels
                        .sort(by: {$0.content.image.rawValue < $1.content.image.rawValue})
                }
                                
                sectionModels.append(SectionModel(section: section,
                                                  title: section.title,
                                                  cell: optionModels,
                                                  isEditable: section != .emotion,
                                                  isVisible: cdSection.isVisible))
            }
        }
                    
        return DiaryDataModel(date: Date(timeIntervalSince1970: model.date),
                              editDate: Date(timeIntervalSince1970: model.editDate),
                              sections: sectionModels)
    }
}
