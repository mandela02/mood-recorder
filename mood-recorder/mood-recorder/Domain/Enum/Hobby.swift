//
//  Hobby.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

enum Hobby: CaseIterable {
    case actionCamera
    case baking
    case barbecue
    case basketball
    case bonsai
    case bowling
    case chat
    case chess
    case cinema
    case coffee
    case game
    case cooking
    case domino
    case exercise
    case skinCare
    case fishing
    case gardening
    case guitar
    case music
    case instantCamera
    case jogging
    case karaoke
    case kayak
    case origami
    case pet
    case piano
    case pingPong
    case plant
    case card
    case reading
    case sewing
    case shopping
    case skateboard
    case football
    case socialMedia
    case surfing
    case swimming
    case telescope
    case tv
    case vr
    case yoga
    
    var option: ImageAndTitleModel {
        switch self {
        case .actionCamera:
            return ImageAndTitleModel(image: AppImage.actionCamera,
                                      title: "Movie making")
        case .baking:
            return ImageAndTitleModel(image: AppImage.baking,
                                      title: "Baking")
        case .barbecue:
            return ImageAndTitleModel(image: AppImage.barbecue,
                                      title: "Barbecue")
        case .basketball:
            return ImageAndTitleModel(image: AppImage.basketball,
                                      title: "Basketball")
        case .bonsai:
            return ImageAndTitleModel(image: AppImage.bonsai,
                                      title: "Bonsai")
        case .bowling:
            return ImageAndTitleModel(image: AppImage.bowling,
                                      title: "Bowling")
        case .chat:
            return ImageAndTitleModel(image: AppImage.chatChit,
                                      title: "Chat")
        case .chess:
            return ImageAndTitleModel(image: AppImage.chess,
                                      title: "Chess")
        case .cinema:
            return ImageAndTitleModel(image: AppImage.cinema,
                                      title: "Watching movie")
        case .coffee:
            return ImageAndTitleModel(image: AppImage.coffeeHobby,
                                      title: "Making coffee")
        case .game:
            return ImageAndTitleModel(image: AppImage.controller,
                                      title: "Game")
        case .cooking:
            return ImageAndTitleModel(image: AppImage.cookingPod,
                                      title: "Cooking")
        case .domino:
            return ImageAndTitleModel(image: AppImage.domino,
                                      title: "Domino")
        case .exercise:
            return ImageAndTitleModel(image: AppImage.exercise,
                                      title: "Exercise")
        case .skinCare:
            return ImageAndTitleModel(image: AppImage.facialMaskhobby,
                                      title: "Skin Care")
        case .fishing:
            return ImageAndTitleModel(image: AppImage.fishing,
                                      title: "Fishing")
        case .gardening:
            return ImageAndTitleModel(image: AppImage.gardening,
                                      title: "Gardening")
        case .guitar:
            return ImageAndTitleModel(image: AppImage.guitar,
                                      title: "Guitar")
        case .music:
            return ImageAndTitleModel(image: AppImage.headphone,
                                      title: "Music")
        case .instantCamera:
            return ImageAndTitleModel(image: AppImage.instantCamera,
                                      title: "Movie making")
        case .jogging:
            return ImageAndTitleModel(image: AppImage.actionCamera,
                                      title: "Photography")
        case .karaoke:
            return ImageAndTitleModel(image: AppImage.karaoke,
                                      title: "Karaoke")
        case .kayak:
            return ImageAndTitleModel(image: AppImage.kayak,
                                      title: "Kayak")
        case .origami:
            return ImageAndTitleModel(image: AppImage.origami,
                                      title: "Origami")
        case .pet:
            return ImageAndTitleModel(image: AppImage.petCare,
                                      title: "Pet")
        case .piano:
            return ImageAndTitleModel(image: AppImage.piano,
                                      title: "Piano")
        case .pingPong:
            return ImageAndTitleModel(image: AppImage.pingPong,
                                      title: "Ping Pong")
        case .plant:
            return ImageAndTitleModel(image: AppImage.plant,
                                      title: "Plant")
        case .card:
            return ImageAndTitleModel(image: AppImage.playingCard,
                                      title: "Card")
        case .reading:
            return ImageAndTitleModel(image: AppImage.readingBook,
                                      title: "Reading")
        case .sewing:
            return ImageAndTitleModel(image: AppImage.sewing,
                                      title: "Sewing")
        case .shopping:
            return ImageAndTitleModel(image: AppImage.shopping,
                                      title: "Shopping")
        case .skateboard:
            return ImageAndTitleModel(image: AppImage.skateboard,
                                      title: "Skateboard")
        case .football:
            return ImageAndTitleModel(image: AppImage.soccerBall,
                                      title: "Football")
        case .socialMedia:
            return ImageAndTitleModel(image: AppImage.smartphonePlay,
                                      title: "Social Network")
        case .surfing:
            return ImageAndTitleModel(image: AppImage.surfing,
                                      title: "Surfing")
        case .swimming:
            return ImageAndTitleModel(image: AppImage.swimming,
                                      title: "Swimming")
        case .telescope:
            return ImageAndTitleModel(image: AppImage.telescopeHobby,
                                      title: "Astronomy")
        case .tv:
            return ImageAndTitleModel(image: AppImage.tvScreen,
                                      title: "Television")
        case .vr:
            return ImageAndTitleModel(image: AppImage.vrGlasses,
                                      title: "VR gaming")
        case .yoga:
            return ImageAndTitleModel(image: AppImage.yoga,
                                      title: "Yoga")
        }
    }
    
    static var defaultOptions: [Hobby] {
        return [.baking, .basketball, .football, .telescope, .yoga, .game, .reading, .cinema, .instantCamera, .pingPong]
    }
}
