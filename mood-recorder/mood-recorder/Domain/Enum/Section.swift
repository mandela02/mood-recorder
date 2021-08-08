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
    case social
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
            return Love.allCases.map { $0.option }
        case .food:
            return Food.allCases.map { $0.option }
        case .health:
            return Medical.allCases.map { $0.option }
        case .chores:
            return []
        case .beauty:
            return Beauty.allCases.map { $0.option }
        case .work:
            return Job.allCases.map { $0.option }
        case .bobby:
            return Hobby.allCases.map { $0.option }
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
