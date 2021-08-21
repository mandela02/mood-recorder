//
//  InputUseCase.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation
import CoreData

protocol InputUseCaseType {
    func save(model: InputDataModel) -> DatabaseResponse
    func update(model: InputDataModel) -> DatabaseResponse
    func fetch(at date: Double) -> DatabaseResponse
    func isRecordExist(date: Double) -> Bool
}

struct InputUseCases: InputUseCaseType {
    private let repository: Repository<CDInputModel>
    private let fetchUseCase: FetchUseCaseType
    
    init(repository: Repository<CDInputModel>) {
        self.repository = repository
        self.fetchUseCase = FetchUseCase(repository: repository)
    }

    var context: NSManagedObjectContext {
        return PersistenceManager.shared.persistentContainer.viewContext
    }
    
    func save(model: InputDataModel) -> DatabaseResponse {
        let cdSections: [CDSectionModel] = createContent(model: model)

        let inputModel = CDInputModel(context: context)
        inputModel.date = model.date.startOfDayInterval
        
        inputModel.addToSections(NSSet(array: cdSections))
        
        return repository.save()
    }
    
    func update(model: InputDataModel) -> DatabaseResponse {
        let result = fetchUseCase.fetch(at: model.date.startOfDayInterval)
        switch result {
        case .success(data: let cdInputModel):
            guard  let cdInputModel = cdInputModel as? CDInputModel else {
                return .error(error: NSError(domain: "Can not find this record",
                                             code: 1,
                                             userInfo: nil))
            }
            
            let sections = createContent(model: model)
            cdInputModel.sections = NSSet(array: sections)
            return repository.save()
        case .error(error: let error):
            return .error(error: error)
        }
    }
    
    func fetch(at date: Double) -> DatabaseResponse {
        let result = fetchUseCase.fetch(at: date)
        switch result {
        case .success(data: let model as CDInputModel):
            return .success(data: fetchUseCase.convert(model: model))
        case .error(let error):
            return.error(error: error)
        default:
            return .error(error: NSError(domain: "Can not find this record",
                                         code: 1,
                                         userInfo: nil))
        }
    }
    
    func isRecordExist(date: Double) -> Bool {
        let result = fetchUseCase.fetch(at: date)
        switch result {
        case .success(data: _):
            return true
        default:
            return false
        }
    }
    
    private func createContent(model: InputDataModel) -> [CDSectionModel] {
        var cdSections: [CDSectionModel] = []
        
        for section in model.sections {
            let cdSection = CDSectionModel(context: context)
            
            cdSection.sectionID = Double(section.section.rawValue)
            cdSection.isVisible = section.isVisible
            
            let cdContent = CDContentModel(context: context)
            
            cdSection.content = cdContent
            
            switch section.cell {
            case let options as [OptionModel]:
                var cdOptions: [CDOptionModel] = []
                
                options.forEach { option in
                    let model = CDOptionModel(context: context)
                    model.name = option.content.title
                    model.image = option.content.image.value
                    model.isSelected = option.isSelected
                    model.isVisible = option.isVisible
                    
                    cdOptions.append(model)
                }
                
                cdContent.addToOptions(NSSet(array: cdOptions))
                
            case let model as ImageModel:
                cdContent.image = model.data
                
            case let model as TextModel:
                cdContent.text = model.text

            case let model as SleepSchelduleModel:
                cdContent.bedTime = model.bedTime
                cdContent.wakeUpTime = model.wakeUpTime
                
            case let model as CoreEmotion:
                cdContent.emotion = Double(model.rawValue)
            default:
                continue
            }
            
            cdSections.append(cdSection)
        }
        
        return cdSections
    }
}