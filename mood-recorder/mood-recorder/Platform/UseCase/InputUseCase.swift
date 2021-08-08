//
//  InputUseCase.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation
import CoreData

class InputUseCase {
    private let repository: Repository<CDInputModel>

    init(repository: Repository<CDInputModel>) {
        self.repository = repository
    }

    var context: NSManagedObjectContext {
        return PersistenceManager.shared.persistentContainer.viewContext
    }
    
    func save(model: InputDataModel) -> DatabaseResponse {
        let sections = model.sections.filter { $0.isVisible }

        var cdSections: [CDSectionModel] = []
        
        for section in sections {
            let cdSection = CDSectionModel(context: context)
            
            cdSection.sectionID = Double(section.section.rawValue)
            
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
        
        let inputModel = CDInputModel(context: context)
        inputModel.date = Date().startOfDay.timeIntervalSince1970
        
        inputModel.addToSections(NSSet(array: cdSections))
        
        return repository.save()
    }
    
    func get() -> DatabaseResponse {
        return repository.countAll()
    }
}
