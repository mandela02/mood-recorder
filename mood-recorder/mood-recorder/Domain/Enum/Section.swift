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
