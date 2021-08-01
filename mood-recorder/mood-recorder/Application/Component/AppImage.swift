//
//  AppImage.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

enum AppImage: String, CaseIterable {
    case blissful
    case happy
    case neutral
    case sad
    case terrible
    
    private var imageName: String {
        switch self {
        case .blissful:
            return "laughing"
        case .happy:
            return "happy"
        case .neutral:
            return "thinking"
        case .sad:
            return "sad"
        case .terrible:
            return "crying"
        }
    }
    
    var image: Image {
        Image(imageName)
    }
}
