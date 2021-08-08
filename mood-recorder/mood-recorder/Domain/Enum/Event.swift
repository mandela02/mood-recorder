//
//  Event.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

enum Event: CaseIterable {
    case auditorium
    case balloons
    case banner
    case beach
    case wedding
    case champagne
    case clown
    case dinnerDate
    case disco
    case carnaval
    case fireworks
    case host
    case magicShow
    case opening
    case photoBooth
    case pinata
    case pizza
    case poolParty
    case redCarpet
    case stage
    case theater
    case movie
    
    var option: ImageAndTitleModel {
        switch self {
        case .auditorium:
            return ImageAndTitleModel(image: AppImage.auditorium,
                               title: "Auditorium")
        case .balloons:
            return ImageAndTitleModel(image: AppImage.balloons,
                               title: "Balloons")
        case .banner:
            return ImageAndTitleModel(image: AppImage.banner,
                               title: "Party")
        case .beach:
            return ImageAndTitleModel(image: AppImage.beach,
                               title: "Beach")
        case .wedding:
            return ImageAndTitleModel(image: AppImage.weddingArch,
                               title: "Wedding")
        case .champagne:
            return ImageAndTitleModel(image: AppImage.champagne,
                               title: "Champagne party")
        case .clown:
            return ImageAndTitleModel(image: AppImage.clown,
                               title: "Clown")
        case .dinnerDate:
            return ImageAndTitleModel(image: AppImage.dinnerTable,
                               title: "Dinner date")
        case .disco:
            return ImageAndTitleModel(image: AppImage.discoBall,
                               title: "Disco")
        case .carnaval:
            return ImageAndTitleModel(image: AppImage.eyeMask,
                               title: "Carnaval")
        case .fireworks:
            return ImageAndTitleModel(image: AppImage.fireworks,
                               title: "Fireworks")
        case .host:
            return ImageAndTitleModel(image: AppImage.host,
                               title: "Gameshow")
        case .magicShow:
            return ImageAndTitleModel(image: AppImage.magicShow,
                               title: "Magic show")
        case .opening:
            return ImageAndTitleModel(image: AppImage.openingCeremony,
                               title: "Opening Ceremony")
        case .photoBooth:
            return ImageAndTitleModel(image: AppImage.photoBooth,
                               title: "Photo Booth")
        case .pinata:
            return ImageAndTitleModel(image: AppImage.pinata,
                               title: "Pinata party")
        case .pizza:
            return ImageAndTitleModel(image: AppImage.pizzaParty,
                               title: "Pizza party")
        case .poolParty:
            return ImageAndTitleModel(image: AppImage.poolParty,
                               title: "Pool Party")
        case .redCarpet:
            return ImageAndTitleModel(image: AppImage.redCarpet,
                               title: "Premiere")
        case .stage:
            return ImageAndTitleModel(image: AppImage.stage,
                               title: "Stage show")
        case .theater:
            return ImageAndTitleModel(image: AppImage.theater,
                               title: "Theater")
        case .movie:
            return ImageAndTitleModel(image: AppImage.videoCamera,
                               title: "Movie")
        }
    }
    
    static var defaultOptions: [Event] {
        return [.auditorium, .theater, .stage, .host, .banner,
                .beach, .carnaval, .wedding, .dinnerDate, .disco]
    }
}
