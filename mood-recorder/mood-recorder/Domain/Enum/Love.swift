//
//  Love.swift
//  mood-recorder
//
//  Created by LanNTH on 07/08/2021.
//

import Foundation

enum Love: Int, CaseIterable {
    case brokenHeart
    case diamonRing
    case fireLove
    case gift
    case lesbian
    case longDistance
    case chocolate
    case gay
    case house
    case letter
    case photo
    case texting
    case rose
    case valentine
    case wine
    case wedding
    case bed
    case inLove
    
    var option: ImageAndTitleModel {
        switch self {
        case .brokenHeart:
            return ImageAndTitleModel(image: AppImage.brokenHeart,
                                      title: "Broken Heart")
        case .diamonRing:
            return ImageAndTitleModel(image: AppImage.diamondRing,
                                      title: "Engagement")
        case .fireLove:
            return ImageAndTitleModel(image: AppImage.fireLove,
                                      title: "Firing Love")
        case .gift:
            return ImageAndTitleModel(image: AppImage.gift,
                                      title: "Gift")
        case .lesbian:
            return ImageAndTitleModel(image: AppImage.lesbian,
                                      title: "Girl & Girl")
        case .longDistance:
            return ImageAndTitleModel(image: AppImage.longDistance,
                                      title: "Long Distance")
        case .chocolate:
            return ImageAndTitleModel(image: AppImage.loveChocolate,
                                      title: "Chocolate")
        case .gay:
            return ImageAndTitleModel(image: AppImage.loveGay,
                                      title: "Boy & Boy")
        case .house:
            return ImageAndTitleModel(image: AppImage.loveHouse,
                                      title: "Moving in")
        case .letter:
            return ImageAndTitleModel(image: AppImage.loveLetter,
                                      title: "Love Letter")
        case .photo:
            return ImageAndTitleModel(image: AppImage.lovePhoto,
                                      title: "Photo together")
        case .texting:
            return ImageAndTitleModel(image: AppImage.loveTexting,
                                      title: "Texting")
        case .rose:
            return ImageAndTitleModel(image: AppImage.roses,
                                      title: "Roses")
        case .valentine:
            return ImageAndTitleModel(image: AppImage.valentine,
                                      title: "Valentine")
        case .wine:
            return ImageAndTitleModel(image: AppImage.wineGlass,
                                      title: "Anniversary")
        case .wedding:
            return ImageAndTitleModel(image: AppImage.weddingRing,
                                      title: "Wedding")
        case .bed:
            return ImageAndTitleModel(image: AppImage.loveBed,
                                      title: "Sex")
        case .inLove:
            return ImageAndTitleModel(image: AppImage.inLove,
                                      title: "In love")
        }
    }
    
    static var defaultOptions: [Love] {
        return [.inLove, .bed, .brokenHeart, .gift, .longDistance]
    }
}
