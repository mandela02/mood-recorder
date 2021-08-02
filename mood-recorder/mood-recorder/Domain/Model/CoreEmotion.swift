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
    
    private var imageName: String {
        switch self {
        case .blissful:
            return AppImage.laughing
        case .happy:
            return AppImage.happy
        case .neutral:
            return AppImage.thinking
        case .sad:
            return AppImage.sad
        case .terrible:
            return AppImage.crying
        }
    }
    
    var image: Image {
        Image(imageName)
    }
}
