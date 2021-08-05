//
//  ThemeHelper.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI

enum Theme: CaseIterable {
    case matchaGreen
    
    private var themeColor: ThemeColor {
        switch self {
        case .matchaGreen:
            return ThemeValue.matchaGreen
        }
    }
    
    static var current: ThemeColor {
        return Theme.matchaGreen.themeColor
    }
}

struct ThemeColor {
    struct NavigationColor {
        var button: Color
        var title: Color
        var background: Color
    }
    
    struct TableViewColor {
        var background: Color
        var cellBackground: Color
        var text: Color
    }
    
    struct ButtonColor {
        var backgroundColor: Color
        var tintColor: Color
        var iconColor: Color
        var disableColor: Color
    }
    
    struct CommonColor {
        var textColor: Color
        var textBackground: Color
    }
    
    let navigationColor: NavigationColor
    let tableViewColor: TableViewColor
    let buttonColor: ButtonColor
    let commonColor: CommonColor
}

struct ThemeValue {
    typealias NavigationColor           = ThemeColor.NavigationColor
    typealias TableViewColor            = ThemeColor.TableViewColor
    typealias ButtonColor               = ThemeColor.ButtonColor
    typealias CommonColor               = ThemeColor.CommonColor
    
    static let matchaGreen = ThemeColor(navigationColor: NavigationColor(button: Color(hex: "FFFFFF"),
                                                                         title: Color(hex: "FFFFFF"),
                                                                         background: Color(hex: "D1E191")),
                                        tableViewColor: TableViewColor(background: Color(hex: "F5FAF4"),
                                                                       cellBackground: Color(hex: "FFFFFF"),
                                                                       text: Color(hex: "767676")),
                                        buttonColor: ButtonColor(backgroundColor: Color(hex: "9AA987"),
                                                                 tintColor: Color(hex: "FFFFFF"),
                                                                 iconColor: Color(hex: "FFFFFF"),
                                                                 disableColor: Color(hex: "EDEDED")),
                                        commonColor: CommonColor(textColor: Color(hex: "767676"),
                                                                 textBackground: Color(hex: "EDEDED")))
}