//
//  Activities.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import Foundation

enum Avatar {
    case pineapple
    case dino
}

var avatar: Avatar = .dino

enum Activities: Int, CaseIterable {
    case angel
    case devil
    case angry
    case birthday
    case blusing
    case confuse
    case cool
    case dancing
    case drunk
    case eating
    case exercise
    case facial
    case idea
    case working
    case chill
    case love
    case scare
    case selfie
    case sick
    case sing
    case sleep
    case surprise
    case science
    
    var option: ImageAndTitleModel {
        switch self {
        case .angel:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.angel : AppImage.angelDino,
                                      title: "Angel")
        case .devil:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.devil : AppImage.devilDino,
                                      title: "Devil")
        case .angry:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.angryPineapple : AppImage.angryRawr,
                                      title: "Angry")
        case .birthday:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.birthdayPineapple : AppImage.birthday,
                                      title: "Angle")
        case .blusing:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.blushing : AppImage.embarrassed,
                                      title: "Blusing")
        case .confuse:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.confuse : AppImage.dizzy,
                                      title: "Confuse")
        case .cool:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.cool : AppImage.coolDino,
                                      title: "Coool")
        case .dancing:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.dancing : AppImage.dancingDino,
                                      title: "Dancer")
        case .drunk:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.drunk : AppImage.drunkDino,
                                      title: "Drunk")
        case .eating:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.eating : AppImage.eat,
                                      title: "Eating")
        case .exercise:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.exercisePineapple : AppImage.exerciseDino,
                                      title: "exercise")
        case .facial:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.beauty : AppImage.facial_treatment,
                                      title: "Skin care")
        case .idea:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.idea : AppImage.ideaDino,
                                      title: "New Idea")
        case .working:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.worker : AppImage.workerDino,
                                      title: "Working")
        case .chill:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.listening : AppImage.music,
                                      title: "Chilling")
        case .love:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.love : AppImage.dinoInlove,
                                      title: "In Love")
        case .scare:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.scare : AppImage.fear,
                                      title: "Scary")
        case .selfie:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.selfie : AppImage.selfieDino,
                                      title: "Selfie")
        case .sick:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.sick : AppImage.sickDino,
                                      title: "Sick")
        case .sing:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.singing : AppImage.sing,
                                      title: "Singing")
        case .sleep:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.sleeping : AppImage.sleepyDino,
                                      title: "Angle")
        case .surprise:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.angel : AppImage.angelDino,
                                      title: "Angle")
        case .science:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.scientist : AppImage.scientist,
                                      title: "Science")
        }
    }
    
    static var defaultOptions: [Activities] {
        return [.angel, .devil, .angry, .confuse, .sick, .sing, .birthday, .chill, .cool, .dancing]
    }
}
