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
            return ImageAndTitleModel(image: AppImage.bigWind.image,
                        title: "Heavy wind")
        case .cloudyDay:
            return ImageAndTitleModel(image: AppImage.cloudyDay.image,
                        title: "Cloudy Day")
        case .cloudyNight:
            return ImageAndTitleModel(image: AppImage.cloudyNight.image,
                        title: "Cloudy Night")

        case .cyclone:
            return ImageAndTitleModel(image: AppImage.cyclone.image,
                        title: "Cyclone")
        case .eclipse:
            return ImageAndTitleModel(image: AppImage.eclipse.image,
                        title: "Eclipse")
        case .heavyRain:
            return ImageAndTitleModel(image: AppImage.heavyRain.image,
                        title: "Heavy Rain")
        case .heavySnow:
            return ImageAndTitleModel(image: AppImage.heavySnow.image,
                        title: "Heavy Snow")
        case .heavyStorm:
            return ImageAndTitleModel(image: AppImage.heavyStorm.image,
                        title: "Heavy Storm")
        case .thunderStorm:
            return ImageAndTitleModel(image: AppImage.heavyThunder.image,
                        title: "Thunder Storm")
        case .newMoon:
            return ImageAndTitleModel(image: AppImage.newMoon.image,
                        title: "New Moon")
        case .rainy:
            return ImageAndTitleModel(image: AppImage.regularRainy.image,
                        title: "Rainy")
        case .snowy:
            return ImageAndTitleModel(image: AppImage.regularSnow.image,
                        title: "Snowy")
        case .sunny:
            return ImageAndTitleModel(image: AppImage.sunny.image,
                        title: "Sunny")
        case .cold:
            return ImageAndTitleModel(image: AppImage.thermometerCold.image,
                        title: "cold")
        case .hot:
            return ImageAndTitleModel(image: AppImage.thermometerHot.image,
                        title: "Hot")
        case .tornado:
            return ImageAndTitleModel(image: AppImage.tornado.image,
                        title: "Tornado")
        case .thunder:
            return ImageAndTitleModel(image: AppImage.thunder.image,
                        title: "Thunder")
        case .fullMoon:
            return ImageAndTitleModel(image: AppImage.fullMoon.image,
                        title: "Full Moon")
        case .sunshower:
            return ImageAndTitleModel(image: AppImage.springRain.image,
                        title: "Sunshower")
        case .rainbow:
            return ImageAndTitleModel(image: AppImage.rainbow.image,
                        title: "Rainbow")
        }
    }
    
    static var defaultOptions: [Weather] {
        return [.sunny, .cloudyDay, .rainy, .snowy, .bigWind]
    }
}
