//
//  Chore.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

enum Chore: Int, CaseIterable {
    case basket
    case broom
    case windowClean
    case carClean
    case floorClean
    case wcClean
    case diskWashing
    case washingMachine
    case waterSpray
    case soap
    case trashBin
    case rake
    case paperTowel
    case houseClean
    case detergent
    case sink
    
    var option: ImageAndTitleModel {
        switch self {
        case .basket:
            return ImageAndTitleModel(image: AppImage.basket,
                                      title: "Laundry basket")
        case .broom:
            return ImageAndTitleModel(image: AppImage.broom2,
                                      title: "Floor sweep")
        case .windowClean:
            return ImageAndTitleModel(image: AppImage.windowCleaning2,
                                      title: "Window cleaning")
        case .carClean:
            return ImageAndTitleModel(image: AppImage.wash,
                                      title: "Car washing")
        case .floorClean:
            return ImageAndTitleModel(image: AppImage.wetFloor,
                                      title: "Floor cleaning")
        case .wcClean:
            return ImageAndTitleModel(image: AppImage.wc,
                                      title: "Toilet cleaning")
        case .diskWashing:
            return ImageAndTitleModel(image: AppImage.washingUp,
                                      title: "Disk washing")
        case .washingMachine:
            return ImageAndTitleModel(image: AppImage.washingMachine,
                                      title: "Wash clothes")
        case .waterSpray:
            return ImageAndTitleModel(image: AppImage.spray2,
                                      title: "Water spray")
        case .soap:
            return ImageAndTitleModel(image: AppImage.soap2,
                                      title: "Soap")
        case .trashBin:
            return ImageAndTitleModel(image: AppImage.rubbishBin2,
                                      title: "Emtpy the trash")
        case .rake:
            return ImageAndTitleModel(image: AppImage.rake,
                                      title: "Rake")
        case .paperTowel:
            return ImageAndTitleModel(image: AppImage.paperTowel,
                                      title: "Paper Towel")
        case .houseClean:
            return ImageAndTitleModel(image: AppImage.houseCleaning,
                                      title: "House cleaning")
        case .detergent:
            return ImageAndTitleModel(image: AppImage.detergent,
                                      title: "Detergent")
        case .sink:
            return ImageAndTitleModel(image: AppImage.sink,
                                      title: "Sink cleaning")
        }
    }
    
    static var defaultOptions: [Chore] {
        return [.diskWashing, .washingMachine, .sink, .wcClean, .carClean]
    }
}
