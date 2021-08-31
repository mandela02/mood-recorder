//
//  CoreEmotion.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

enum CoreEmotion: Int, CaseIterable {
    case blissful
    case happy
    case neutral
    case sad
    case terrible
    
    var imageName: AppImage {
        let avatar = Avatar.get()
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
    
    var color: Color {
        switch self {
        case .blissful:
            return Color(hex: "eedc88")
        case .happy:
            return Color(hex: "b7d68a")
        case .neutral:
            return Color(hex: "60ae72")
        case .sad:
            return Color(hex: "3b7851")
        case .terrible:
            return Color(hex: "6b7773")
        }
    }
    
    var doubleValue: Double {
        return Double(self.rawValue)
    }
    
    var image: Image {
        Image(imageName.value)
    }
}
