//
//  InputDataModel.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

enum Section: CaseIterable {
    case emotion
    case activity
    case weather
    case social
    case school
    case romance
    case food
    case snack
    case health
    case chores
    case beauty
    case work
    case bobby
    case event
    case sleep
    case note
    case photo
    case custom
    
    var allOptions: [ImageAndTitleModel] {
        switch self {
        case .emotion:
            return CoreEmotion
                .allCases
                .map { ImageAndTitleModel(image: $0.imageName,
                                          title: "") }
        case .activity:
            return Activities.allCases.map { $0.option }
        case .weather:
            return Weather.allCases.map { $0.option }
        case .social:
            return []
        case .school:
            return []
        case .romance:
            return []
        case .food:
            return []
        case .snack:
            return []
        case .health:
            return []
        case .chores:
            return []
        case .beauty:
            return []
        case .work:
            return []
        case .bobby:
            return []
        case .event:
            return []
        case .sleep:
            return []
        case .note:
            return []
        case .photo:
            return []
        case .custom:
            return []
        }
    }
}

enum CellType {
    case option(models: [OptionModel])
    case write(content: String?)
    case photo(image: Data?)
    case sleep(model: SleepSchelduleModel?)
}

struct ImageAndTitleModel {
    let image: String
    let title: String
}

struct SleepSchelduleModel {
    let startTime: Int?
    let endTime: Int?
}

struct OptionModel {
    let content: ImageAndTitleModel
    var isVisible: Bool = true
    var isSelected: Bool = false
}

struct SectionModel {
    let section: Section
    let title: String
    
    var cell: CellType
    
    var isSelected: Bool = true
    var isEditable: Bool = true
}

struct InputDataModel {
    var sections: [SectionModel]
    
    var visibleSections: [SectionModel] {
        return sections.filter { $0.isSelected }
    }
    
    var hiddenSections: [SectionModel] {
        return sections.filter { !$0.isSelected }
    }
    
    static func initData() -> InputDataModel {
        let sections = Section.allCases.map { section -> SectionModel in
            switch section {
            case .emotion:
                let models = section.allOptions.map {OptionModel(content: $0)  }
                
                return SectionModel(section: section,
                                    title: "How was your day?",
                                    cell: .option(models: models),
                                    isEditable: false)
                
            case .activity:
                let contentModels = Activities.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Tell something about your day!!",
                                    cell: .option(models: contentModels))
            case .weather:
                let contentModels = Weather.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }
                
                return SectionModel(section: section,
                                    title: "What are you thinking?",
                                    cell: .option(models: contentModels))
            case .social:
                return SectionModel(section: section,
                                    title: "What are you thinking?",
                                    cell: .option(models: []))
            case .school:
                return SectionModel(section: section,
                                    title: "What did you do in school?",
                                    cell: .option(models: []))
            case .romance:
                return SectionModel(section: section,
                                    title: "Is love in the air tonight?",
                                    cell: .option(models: []))
            case .food:
                return SectionModel(section: section,
                                    title: "Do you enjoy your meal?",
                                    cell: .option(models: []))
            case .snack:
                return SectionModel(section: section,
                                    title: "Having a little snack?",
                                    cell: .option(models: []))
            case .health:
                return SectionModel(section: section,
                                    title: "Is there anything wrong? Are you ok?",
                                    cell: .option(models: []))
            case .chores:
                return SectionModel(section: section,
                                    title: "Did you clean your house today?",
                                    cell: .option(models: []))
            case .beauty:
                return SectionModel(section: section,
                                    title: "Remember take care of yourself!",
                                    cell: .option(models: []))
            case .work:
                return SectionModel(section: section,
                                    title: "Was your boss annoy you today?",
                                    cell: .option(models: []))
            case .bobby:
                return SectionModel(section: section,
                                    title: "Did you enjoy yourself?",
                                    cell: .option(models: []))
            case .event:
                return SectionModel(section: section,
                                    title: "Which events did you attend?",
                                    cell: .option(models: []))
            case .sleep:
                return SectionModel(section: section,
                                    title: "How was your sleep?",
                                    cell: .sleep(model: nil))
            case .note:
                return SectionModel(section: section,
                                    title: "What are you thinking?",
                                    cell: .write(content: nil))
            case .photo:
                return SectionModel(section: section,
                                    title: "Picture of the day",
                                    cell: .photo(image: nil))
            case .custom:
                return SectionModel(section: section,
                                    title: "Your own block",
                                    cell: .option(models: []))
            }
        }
        
        return InputDataModel(sections: sections)
    }
}
