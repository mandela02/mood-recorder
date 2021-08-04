//
//  CoreEmotion.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

enum CoreEmotion: String, CaseIterable {
    case blissful
    case happy
    case neutral
    case sad
    case terrible
    
    var imageName: String {
        switch self {
        case .blissful:
            return avatar == .pineapple ? AppImage.laughing : AppImage.laughingDino
        case .happy:
            return avatar == .pineapple ? AppImage.happy : AppImage.happyDino
        case .neutral:
            return avatar == .pineapple ? AppImage.thinking : AppImage.think
        case .sad:
            return avatar == .pineapple ? AppImage.sad : AppImage.angry
        case .terrible:
            return avatar == .pineapple ? AppImage.crying : AppImage.dinoCrying
        }
    }
    
    var image: Image {
        Image(imageName)
    }
}
