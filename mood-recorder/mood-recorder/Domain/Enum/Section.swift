//
//  Section.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

enum Section: Int, CaseIterable {
    case emotion
    case activity
    case weather
    case school
    case romance
    case food
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
    
    static func section(from id: Int) -> Section {
        return Section.allCases[id]
    }
    
    var title: String {
        switch self {
        case .emotion:
            return "How was your day?"
        case .activity:
            return "Tell something about your day!!"
        case .weather:
            return "What the weather like today??"
        case .school:
            return "What did you do in school?"
        case .romance:
            return "Is love in the air tonight?"
        case .food:
            return "Do you enjoy your meal?"
        case .health:
            return "Is there anything wrong? Are you ok?"
        case .chores:
            return "Did you clean your house today?"
        case .beauty:
            return "Remember take care of yourself!"
        case .work:
            return "Was your boss annoy you today?"
        case .bobby:
            return "Did you enjoy yourself?"
        case .event:
            return "Which events did you attend?"
        case .sleep:
            return "How was your sleep?"
        case .note:
            return "What are you thinking?"
        case .photo:
            return "Picture of the day"
        case .custom:
            return "Your own block"
        }
    }
        
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
        case .school:
            return School.allCases.map { $0.option }
        case .romance:
            return Love.allCases.map { $0.option }
        case .food:
            return Food.allCases.map { $0.option }
        case .health:
            return Medical.allCases.map { $0.option }
        case .chores:
            return Chore.allCases.map { $0.option }
        case .beauty:
            return Beauty.allCases.map { $0.option }
        case .work:
            return Job.allCases.map { $0.option }
        case .bobby:
            return Hobby.allCases.map { $0.option }
        case .event:
            return Event.allCases.map { $0.option }
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
