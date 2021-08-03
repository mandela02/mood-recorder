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

struct ImageAndTitleModel {
    let image: String
    let title: String
}

class SleepSchelduleModel {
    init(startTime: Int? = nil, endTime: Int? = nil) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var startTime: Int?
    var endTime: Int?
}


class OptionModel: Equatable, Identifiable {
    static func == (lhs: OptionModel, rhs: OptionModel) -> Bool {
        lhs.id == rhs.id
    }
    
    init(content: ImageAndTitleModel) {
        self.content = content
    }
    
    let id = UUID()
    
    let content: ImageAndTitleModel
    
    var isVisible: Bool = true
    var isSelected: Bool = false
}

class SectionModel: Identifiable {
    init(section: Section, title: String, cell: Any?, isEditable: Bool = true) {
        self.section = section
        self.title = title
        self.cell = cell
        self.isEditable = isEditable
    }
    
    let id = UUID()
    
    let section: Section
    let title: String
    
    var cell: Any?
    
    var isVisible: Bool = true
    var isEditable: Bool = true
}

class InputDataModel {
    init(sections: [SectionModel]) {
        self.sections = sections
    }
    
    var sections: [SectionModel]
    
    var visibleSections: [SectionModel] {
        return sections.filter { $0.isVisible }
    }
    
    var hiddenSections: [SectionModel] {
        return sections.filter { !$0.isVisible }
    }
    
    static func initData() -> InputDataModel {
        let sections = Section.allCases.map { section -> SectionModel in
            switch section {
            case .emotion:
                let models = section.allOptions.map {OptionModel(content: $0)  }
                
                return SectionModel(section: section,
                                    title: "How was your day?",
                                    cell: models,
                                    isEditable: false)
                
            case .activity:
                let models = Activities.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Tell something about your day!!",
                                    cell: models)
            case .weather:
                let contentModels = Weather.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }
                
                return SectionModel(section: section,
                                    title: "What are you thinking?",
                                    cell: contentModels)
            case .social:
                return SectionModel(section: section,
                                    title: "What are you thinking?",
                                    cell: [])
            case .school:
                return SectionModel(section: section,
                                    title: "What did you do in school?",
                                    cell: [])
            case .romance:
                return SectionModel(section: section,
                                    title: "Is love in the air tonight?",
                                    cell: [])
            case .food:
                return SectionModel(section: section,
                                    title: "Do you enjoy your meal?",
                                    cell: [])
            case .snack:
                return SectionModel(section: section,
                                    title: "Having a little snack?",
                                    cell: [])
            case .health:
                return SectionModel(section: section,
                                    title: "Is there anything wrong? Are you ok?",
                                    cell: [])
            case .chores:
                return SectionModel(section: section,
                                    title: "Did you clean your house today?",
                                    cell: [])
            case .beauty:
                return SectionModel(section: section,
                                    title: "Remember take care of yourself!",
                                    cell: [])
            case .work:
                return SectionModel(section: section,
                                    title: "Was your boss annoy you today?",
                                    cell: [])
            case .bobby:
                return SectionModel(section: section,
                                    title: "Did you enjoy yourself?",
                                    cell: [])
            case .event:
                return SectionModel(section: section,
                                    title: "Which events did you attend?",
                                    cell: [])
            case .sleep:
                return SectionModel(section: section,
                                    title: "How was your sleep?",
                                    cell: SleepSchelduleModel())
            case .note:
                return SectionModel(section: section,
                                    title: "What are you thinking?",
                                    cell: nil)
            case .photo:
                return SectionModel(section: section,
                                    title: "Picture of the day",
                                    cell: nil)
            case .custom:
                return SectionModel(section: section,
                                    title: "Your own block",
                                    cell: [])
            }
        }
        
        return InputDataModel(sections: sections)
    }
}
