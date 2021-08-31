//
//  Font.swift
//  Pokedex
//
//  Created by TriBQ on 14/10/2020.
//

import Foundation
import SwiftUI

enum Biotif {
    case black(size: CGFloat)
    case blackItalic(size: CGFloat)
    case bold(size: CGFloat)
    case boldItalic(size: CGFloat)
    case book(size: CGFloat)
    case bookItalic(size: CGFloat)
    case extraBold(size: CGFloat)
    case extraBoldItalic(size: CGFloat)
    case light(size: CGFloat)
    case ligthItalic(size: CGFloat)
    case medium(size: CGFloat)
    case mediumItalic(size: CGFloat)
    case regular(size: CGFloat)
    case regularItalic(size: CGFloat)
    case semiBold(size: CGFloat)
    case semiBoldItalic(size: CGFloat)
    
    var font: Font {
        switch self {
        case .black(size: let size):
            return .custom("Biotif-Black", size: size)
        case .blackItalic(size: let size):
            return .custom("Biotif-BlackItalic", size: size)
        case .bold(size: let size):
            return .custom("Biotif-Bold", size: size)
        case .boldItalic(size: let size):
            return .custom("Biotif-BoldItalic", size: size)
        case .book(size: let size):
            return .custom("Biotif-Book", size: size)
        case .bookItalic(size: let size):
            return .custom("Biotif-BookItalic", size: size)
        case .extraBold(size: let size):
            return .custom("Biotif-ExtraBold", size: size)
        case .extraBoldItalic(size: let size):
            return .custom("Biotif-ExtraBoldItalic", size: size)
        case .light(size: let size):
            return .custom("Biotif-Light", size: size)
        case .ligthItalic(size: let size):
            return .custom("Biotif-LigthItalic", size: size)
        case .medium(size: let size):
            return .custom("Biotif-Medium", size: size)
        case .mediumItalic(size: let size):
            return .custom("Biotif-MediumItalic", size: size)
        case .regular(size: let size):
            return .custom("Biotif-Regular", size: size)
        case .regularItalic(size: let size):
            return .custom("Biotif-RegularItalic", size: size)
        case .semiBold(size: let size):
            return .custom("Biotif-SemiBold", size: size)
        case .semiBoldItalic(size: let size):
            return .custom("Biotif-SemiBoldItalic", size: size)
        }
    }
}
