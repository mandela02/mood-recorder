//
//  School.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

enum School: Int, CaseIterable {
    case alarmClock
    case atom
    case blackboard
    case books
    case calculator
    case colorPalette
    case compass
    case dictionary
    case diploma
    case dna
    case examFail
    case exam
    case field
    case flask
    case flute
    case geography
    case laptop
    case medal
    case microscope
    case schoolBus
    case school
    case sculpture
    case solarSystem
    case studentCard
    case telescope
    case whistle
    case trophy
    
    var option: ImageAndTitleModel {
        switch self {
        case .alarmClock:
            return ImageAndTitleModel(image: AppImage.alarmClock,
                                      title: "New Clock")
        case .atom:
            return ImageAndTitleModel(image: AppImage.atom,
                                      title: "Physic")
        case .blackboard:
            return ImageAndTitleModel(image: AppImage.blackboard,
                                      title: "Math")
        case .books:
            return ImageAndTitleModel(image: AppImage.books,
                                      title: "Read new book")
        case .calculator:
            return ImageAndTitleModel(image: AppImage.calculator,
                                      title: "algebra")
        case .colorPalette:
            return ImageAndTitleModel(image: AppImage.colorPalette,
                                      title: "Art")
        case .compass:
            return ImageAndTitleModel(image: AppImage.compass,
                                      title: "Geometry")
        case .dictionary:
            return ImageAndTitleModel(image: AppImage.dictionary,
                                      title: "Language")
        case .diploma:
            return ImageAndTitleModel(image: AppImage.diploma,
                                      title: "Graduation")
        case .dna:
            return ImageAndTitleModel(image: AppImage.dna,
                                      title: "Biology")
        case .examFail:
            return ImageAndTitleModel(image: AppImage.examFail,
                                      title: "Exam fail")
        case .exam:
            return ImageAndTitleModel(image: AppImage.exam,
                                      title: "Exam pass")
        case .field:
            return ImageAndTitleModel(image: AppImage.field,
                                      title: "Sport")
        case .flask:
            return ImageAndTitleModel(image: AppImage.flask,
                                      title: "Chemistry")
        case .flute:
            return ImageAndTitleModel(image: AppImage.flute,
                                      title: "Music")
        case .geography:
            return ImageAndTitleModel(image: AppImage.geography,
                                      title: "Geography")
        case .laptop:
            return ImageAndTitleModel(image: AppImage.laptop,
                                      title: "IT")
        case .medal:
            return ImageAndTitleModel(image: AppImage.medal,
                                      title: "Medal")
        case .microscope:
            return ImageAndTitleModel(image: AppImage.microscope,
                                      title: "Microscope")
        case .schoolBus:
            return ImageAndTitleModel(image: AppImage.schoolBus,
                                      title: "School Bus")
        case .school:
            return ImageAndTitleModel(image: AppImage.school,
                                      title: "New school")
        case .sculpture:
            return ImageAndTitleModel(image: AppImage.sculpture,
                                      title: "Sculpture")
        case .solarSystem:
            return ImageAndTitleModel(image: AppImage.solarSystem,
                                      title: "Solar System")
        case .studentCard:
            return ImageAndTitleModel(image: AppImage.studentCard,
                                      title: "New Student Card")
        case .telescope:
            return ImageAndTitleModel(image: AppImage.telescope,
                                      title: "Astronomy")
        case .whistle:
            return ImageAndTitleModel(image: AppImage.whistle,
                                      title: "Training")
        case .trophy:
            return ImageAndTitleModel(image: AppImage.trophy,
                                      title: "Trophy")
        }
    }
    
    static var defaultOptions: [School] {
        return [.exam, .atom, .books, .blackboard, .colorPalette, .sculpture, .solarSystem, .field, .trophy, .examFail]
    }
}
