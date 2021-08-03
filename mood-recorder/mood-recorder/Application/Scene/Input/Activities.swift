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

var avatar: Avatar = .pineapple

enum Activities: CaseIterable {
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
    case thinking
    case science
    
    var option: ImageAndTitleModel {
        switch self {
        case .angel:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.angel.image : AppImage.angelDino.image,
                                      title: "Angle")
        case .devil:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.devil.image : AppImage.devilDino.image,
                                      title: "Devil")
        case .angry:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.angryPineapple.image : AppImage.angryRawr.image,
                                      title: "Angry")
        case .birthday:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.birthdayPineapple.image : AppImage.birthday.image,
                                      title: "Angle")
        case .blusing:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.blushing.image : AppImage.embarrassed.image,
                                      title: "Blusing")
        case .confuse:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.confuse.image : AppImage.dizzy.image,
                                      title: "confuse")
        case .cool:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.cool.image : AppImage.coolDino.image,
                                      title: "Coool")
        case .dancing:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.dancing.image : AppImage.dancingDino.image,
                                      title: "Dancer")
        case .drunk:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.drunk.image : AppImage.drunkDino.image,
                                      title: "Drunk")
        case .eating:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.eating.image : AppImage.eat.image,
                                      title: "Eating")
        case .exercise:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.exercisePineapple.image : AppImage.exerciseDino.image,
                                      title: "exercise")
        case .facial:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.beauty.image : AppImage.facial_treatment.image,
                                      title: "Skin care")
        case .idea:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.idea.image : AppImage.ideaDino.image,
                                      title: "New Idea")
        case .working:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.worker.image : AppImage.workerDino.image,
                                      title: "Working")
        case .chill:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.listening.image : AppImage.music.image,
                                      title: "Chilling")
        case .love:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.love.image : AppImage.dinoInlove.image,
                                      title: "In Love")
        case .scare:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.scare.image : AppImage.fear.image,
                                      title: "Scary")
        case .selfie:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.selfie.image : AppImage.selfieDino.image,
                                      title: "Selfie")
        case .sick:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.sick.image : AppImage.sickDino.image,
                                      title: "Sick")
        case .sing:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.singing.image : AppImage.sing.image,
                                      title: "Singing")
        case .sleep:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.sleeping.image : AppImage.sleepyDino.image,
                                      title: "Angle")
        case .surprise:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.angel.image : AppImage.angelDino.image,
                                      title: "Angle")
        case .thinking:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.thinking.image : AppImage.think.image,
                                      title: "Thinking")
        case .science:
            return ImageAndTitleModel(image: avatar == .pineapple ? AppImage.scientist.image : AppImage.scientist.image,
                                      title: "Science")
        }
    }
    
    static var defaultOptions: [Activities] {
        return [.angel, .angry, .confuse, .confuse, .sing]
    }
}
