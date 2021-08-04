//
//  Weather.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import Foundation

enum Weather: CaseIterable {
    case bigWind
    case cloudyDay
    case cloudyNight
    case cyclone
    case eclipse
    case heavyRain
    case heavySnow
    case heavyStorm
    case thunderStorm
    case newMoon
    case rainy
    case snowy
    case sunny
    case cold
    case hot
    case tornado
    case thunder
    case fullMoon
    case sunshower
    case rainbow
    
    var option: ImageAndTitleModel {
        switch self {
        case .bigWind:
            return ImageAndTitleModel(image: AppImage.bigWind,
                                      title: "Heavy wind")
        case .cloudyDay:
            return ImageAndTitleModel(image: AppImage.cloudyDay,
                                      title: "Cloudy Day")
        case .cloudyNight:
            return ImageAndTitleModel(image: AppImage.cloudyNight,
                                      title: "Cloudy Night")
            
        case .cyclone:
            return ImageAndTitleModel(image: AppImage.cyclone,
                                      title: "Cyclone")
        case .eclipse:
            return ImageAndTitleModel(image: AppImage.eclipse,
                                      title: "Eclipse")
        case .heavyRain:
            return ImageAndTitleModel(image: AppImage.heavyRain,
                                      title: "Heavy Rain")
        case .heavySnow:
            return ImageAndTitleModel(image: AppImage.heavySnow,
                                      title: "Heavy Snow")
        case .heavyStorm:
            return ImageAndTitleModel(image: AppImage.heavyStorm,
                                      title: "Heavy Storm")
        case .thunderStorm:
            return ImageAndTitleModel(image: AppImage.heavyThunder,
                                      title: "Thunder Storm")
        case .newMoon:
            return ImageAndTitleModel(image: AppImage.newMoon,
                                      title: "New Moon")
        case .rainy:
            return ImageAndTitleModel(image: AppImage.regularRainy,
                                      title: "Rainy")
        case .snowy:
            return ImageAndTitleModel(image: AppImage.regularSnow,
                                      title: "Snowy")
        case .sunny:
            return ImageAndTitleModel(image: AppImage.sunny,
                                      title: "Sunny")
        case .cold:
            return ImageAndTitleModel(image: AppImage.thermometerCold,
                                      title: "cold")
        case .hot:
            return ImageAndTitleModel(image: AppImage.thermometerHot,
                                      title: "Hot")
        case .tornado:
            return ImageAndTitleModel(image: AppImage.tornado,
                                      title: "Tornado")
        case .thunder:
            return ImageAndTitleModel(image: AppImage.thunder,
                                      title: "Thunder")
        case .fullMoon:
            return ImageAndTitleModel(image: AppImage.fullMoon,
                                      title: "Full Moon")
        case .sunshower:
            return ImageAndTitleModel(image: AppImage.springRain,
                                      title: "Sunshower")
        case .rainbow:
            return ImageAndTitleModel(image: AppImage.rainbow,
                                      title: "Rainbow")
        }
    }
    
    static var defaultOptions: [Weather] {
        return [.sunny, .cloudyDay, .rainy, .snowy, .bigWind, rainbow, thunderStorm, heavyRain, .hot, cold,]
    }
}
