//
//  InputDataModel.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import Foundation

struct InputDataModel {
    init(sections: [SectionModel]) {
        self.sections = sections
    }
    
    var sections: [SectionModel]
    
    static func initData() -> InputDataModel {
        let sections = SectionType.allCases.map { section -> SectionModel in
            switch section {
            case .emotion:
                let models = CoreEmotion
                    .allCases
                    .map {
                        OptionModel(content: ImageAndTitleModel(image: $0.imageName,
                                                                title: ""),
                                    optionID: $0.rawValue)
                    }
                
                return SectionModel(section: section,
                                    title: "How was your day?",
                                    cell: models,
                                    isEditable: false)
                
            case .activity:
                let models = Activities.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Tell something about your day!!",
                                    cell: models)
            case .weather:
                let models = Weather.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "What the weather like today??",
                                    cell: models)

            case .school:
                let models = School.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "What did you do in school?",
                                    cell: models)
            case .romance:
                let models = Love.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }


                return SectionModel(section: section,
                                    title: "Is love in the air tonight?",
                                    cell: models)
            case .food:
                let models = Food.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Do you enjoy your meal?",
                                    cell: models)
            case .health:
                let models = Medical.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Is there anything wrong? Are you ok?",
                                    cell: models)
            case .chores:
                let models = Chore.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Did you clean your house today?",
                                    cell: models)
            case .beauty:
                let models = Beauty.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Remember take care of yourself!",
                                    cell: models)
            case .work:
                let models = Job.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Was your boss annoy you today?",
                                    cell: models)
            case .bobby:
                let models = Hobby.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Did you enjoy yourself?",
                                    cell: models)
            case .event:
                let models = Event.defaultOptions
                    .map { OptionModel(content: $0.option, optionID: $0.rawValue) }

                return SectionModel(section: section,
                                    title: "Which events did you attend?",
                                    cell: models)
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
