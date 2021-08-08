//
//  InputDataModel.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import Foundation

class InputDataModel {
    init(sections: [SectionModel]) {
        self.sections = sections
    }
    
    var sections: [SectionModel]
    
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
                                    title: "What the weather like today??",
                                    cell: contentModels)

            case .school:
                let contentModels = School.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "What did you do in school?",
                                    cell: contentModels)
            case .romance:
                let contentModels = Love.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }


                return SectionModel(section: section,
                                    title: "Is love in the air tonight?",
                                    cell: contentModels)
            case .food:
                let contentModels = Food.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Do you enjoy your meal?",
                                    cell: contentModels)
            case .health:
                let contentModels = Medical.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Is there anything wrong? Are you ok?",
                                    cell: contentModels)
            case .chores:
                let contentModels = Chore.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Did you clean your house today?",
                                    cell: contentModels)
            case .beauty:
                let contentModels = Beauty.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Remember take care of yourself!",
                                    cell: contentModels)
            case .work:
                let contentModels = Job.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Was your boss annoy you today?",
                                    cell: contentModels)
            case .bobby:
                let contentModels = Hobby.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Did you enjoy yourself?",
                                    cell: contentModels)
            case .event:
                let contentModels = Event.defaultOptions
                    .map { $0.option }
                    .map { OptionModel(content: $0) }

                return SectionModel(section: section,
                                    title: "Which events did you attend?",
                                    cell: contentModels)
            case .sleep:
                return SectionModel(section: section,
                                    title: "How was your sleep?",
                                    cell: SleepSchelduleModel())
            case .note:
                return SectionModel(section: section,
                                    title: "What are you thinking?",
                                    cell: TextModel())
            case .photo:
                return SectionModel(section: section,
                                    title: "Picture of the day",
                                    cell: ImageModel())
            case .custom:
                return SectionModel(section: section,
                                    title: "Your own block",
                                    cell: [])
            }
        }
        
        return InputDataModel(sections: sections)
    }
}
