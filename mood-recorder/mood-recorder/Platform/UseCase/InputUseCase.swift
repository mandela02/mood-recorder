//
//  InputUseCase.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation
import CoreData

struct InputUseCase {
    private let repository: Repository<CDInputModel>

    init(repository: Repository<CDInputModel>) {
        self.repository = repository
    }

    var context: NSManagedObjectContext {
        return PersistenceManager.shared.persistentContainer.viewContext
    }
    
    func save(model: InputDataModel) -> DatabaseResponse {
        let cdSections: [CDSectionModel] = createContent(model: model)

        let inputModel = CDInputModel(context: context)
        inputModel.date = Date().startOfDay.timeIntervalSince1970
        
        inputModel.addToSections(NSSet(array: cdSections))
        
        return repository.save()
    }
    
    func update(at date: Double, model: InputDataModel) -> DatabaseResponse {
        let result = repository.fetchRequest(predicate: "date", value: "\(date)")
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
        let result = repository.fetchRequest(predicate: "date", value: "\(date)")
        switch result {
        case .success(data: let model as CDInputModel):
            var sectionModels = [SectionModel]()
            
            for cdSection in model.sectionArray {
                guard let content = cdSection.content else { continue }
                let section = Section.section(from: Int(cdSection.sectionID))
                
                switch section {
                case .note:
                    sectionModels.append(SectionModel(section: section,
                                                      title: section.title,
                                                      cell: TextModel(text: content.text),
                                                      isVisible: cdSection.isVisible))
                case .photo:
                    sectionModels.append(SectionModel(section: section,
                                                      title: section.title,
                                                      cell: ImageModel(data: content.image)))
                case .sleep:
                    sectionModels.append(SectionModel(section: section,
                                                      title: section.title,
                                                      cell: SleepSchelduleModel(startTime: content.startDate,
                                                                                endTime: content.endDate),
                                                      isVisible: cdSection.isVisible))
                default:
                    let cdOptions = content.optionArray
                    var optionModels = [OptionModel]()
                    
                    for cdOption in cdOptions {
                        optionModels.append(OptionModel(content: section.allOptions[Int(cdOption.optionID)],
                                                       optionID: Int(cdOption.optionID),
                                                       isSelected: cdOption.isSelected))
                    }
                    
                    sectionModels.append(SectionModel(section: section,
                                                      title: section.title,
                                                      cell: optionModels,
                                                      isEditable: section != .emotion,
                                                      isVisible: cdSection.isVisible))
                }
            }
            
            return .success(data: InputDataModel(sections: sectionModels))
        case .error(error: let error):
            return .error(error: error)
        default:
            return .error(error: NSError(domain: "Can not find this record",
                                         code: 1,
                                         userInfo: nil))
        }
    }
    
    func isRecordExist(date: Double) -> Bool {
        let result = repository.fetchRequest(predicate: "date", value: "\(date)")
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
                    model.optionID = Double(option.optionID)
                    model.isSelected = option.isSelected
                    
                    cdOptions.append(model)
                }
                
                cdContent.addToOptions(NSSet(array: cdOptions))
                
            case let model as ImageModel:
                cdContent.image = model.data
                
            case let model as TextModel:
                cdContent.text = model.text

            case let model as SleepSchelduleModel:
                cdContent.startDate = model.startTime ?? 00
                cdContent.endDate = model.endTime ?? 00
                
            default:
                continue
            }
            
            cdSections.append(cdSection)
        }
        
        return cdSections
    }
}
