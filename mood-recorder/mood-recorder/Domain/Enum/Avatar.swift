//
//  Avatar.swift
//  Avatar
//
//  Created by TriBQ on 8/30/21.
//

import SwiftUI

enum Avatar: Int, CaseIterable, StringValueProtocol {
    case dino
    case pineapple
    
    static func get() -> Avatar {
        return Avatar(rawValue: Settings.avatar.value) ?? .dino
    }
    
    static func get(id: Int) -> Avatar {
        return Avatar(rawValue: id) ?? .dino
    }
    
    var value: String {
        switch self {
        case .pineapple:
            return "Pineapple"
        case .dino:
            return "Dino"
        }
    }
    
    var image: Image {
        switch self {
        case .pineapple:
            return AppImage.cool.value.image
        case .dino:
            return AppImage.beauty1.value.image
        }
    }
    
    var darkSideImage: Image {
        switch self {
        case .pineapple:
            return AppImage.devil.value.image
        case .dino:
            return AppImage.devilDino.value.image
        }
    }
    
    var lightSizeImage: Image {
        switch self {
        case .pineapple:
            return AppImage.angel.value.image
        case .dino:
            return AppImage.angelDino.value.image
        }
    }
}
