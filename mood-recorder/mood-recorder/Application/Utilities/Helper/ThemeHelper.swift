//
//  ThemeHelper.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI

enum Theme: Int, CaseIterable {
    case lightMode
    case nightMode
    
    private var themeColor: ThemeColor {
        switch self {
        case .lightMode:
            return ThemeValue.matchaGreen
        case .nightMode:
            return ThemeValue.momotoneBlack
        }
    }
    
    static var currentTheme: Theme {
        Settings.themeId.value == 1 ? .nightMode : lightMode
    }
    
    static var current: ThemeColor {
        return Theme.allCases[safe: Settings.themeId.value]?.themeColor ?? Theme.lightMode.themeColor
    }
    
    static func post(themeId: Int) {
        Settings.themeId.value = themeId
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
        var textColor: Color
        var iconColor: Color
        var disableColor: Color
    }
    
    struct CommonColor {
        var textColor: Color
        var textBackground: Color
        var viewBackground: Color
    }
    
    struct SleepColor {
        var backgroundColor: Color
        var bigCircleColor: Color
        var smallCircleColor: Color
        var textColor: Color
        var buttonColor: Color
        var buttonBackground: Color
    }
    
    let navigationColor: NavigationColor
    let tableViewColor: TableViewColor
    let buttonColor: ButtonColor
    let commonColor: CommonColor
    let sleepColor: SleepColor
}

struct ThemeValue {
    typealias NavigationColor           = ThemeColor.NavigationColor
    typealias TableViewColor            = ThemeColor.TableViewColor
    typealias ButtonColor               = ThemeColor.ButtonColor
    typealias CommonColor               = ThemeColor.CommonColor
    typealias SleepColor                = ThemeColor.SleepColor
    
    static let matchaGreen = ThemeColor(navigationColor: NavigationColor(button: Color(hex: "FFFFFF"),
                                                                         title: Color(hex: "FFFFFF"),
                                                                         background: Color(hex: "D1E191")),
                                        tableViewColor: TableViewColor(background: Color(hex: "F5FAF4"),
                                                                       cellBackground: Color(hex: "FFFFFF"),
                                                                       text: Color(hex: "767676")),
                                        buttonColor: ButtonColor(backgroundColor: Color(hex: "9AA987"),
                                                                 textColor: Color(hex: "FFFFFF"),
                                                                 iconColor: Color(hex: "FFFFFF"),
                                                                 disableColor: Color(hex: "EDEDED")),
                                        commonColor: CommonColor(textColor: Color(hex: "767676"),
                                                                 textBackground: Color(hex: "EDEDED"),
                                                                 viewBackground: Color(hex: "F5FAF4")),
                                        sleepColor: SleepColor(backgroundColor: Color(hex: "F5FAF4"),
                                                               bigCircleColor: Color(hex: "EDEDED"),
                                                               smallCircleColor: Color(hex: "9AA987"),
                                                               textColor: Color(hex: "767676"),
                                                               buttonColor: Color(hex: "9AA987"),
                                                               buttonBackground: Color(hex: "FFFFFF")))
    
    static let momotoneBlack = ThemeColor(navigationColor: NavigationColor(button: Color(hex: "FFFFFF"),
                                                                           title: Color(hex: "FFFFFF"),
                                                                           background: Color(hex: "D1E191")),
                                          tableViewColor: TableViewColor(background: Color(hex: "000000"),
                                                                         cellBackground: Color(hex: "17191A"),
                                                                         text: Color(hex: "FFFFFF")),
                                          buttonColor: ButtonColor(backgroundColor: Color(hex: "9AA987"),
                                                                   textColor: Color(hex: "FFFFFF"),
                                                                   iconColor: Color(hex: "FFFFFF"),
                                                                   disableColor: Color(hex: "EDEDED")),
                                          commonColor: CommonColor(textColor: Color(hex: "767676"),
                                                                   textBackground: Color(hex: "EDEDED"),
                                                                   viewBackground: Color(hex: "F5FAF4")),
                                          sleepColor: SleepColor(backgroundColor: Color(hex: "F5FAF4"),
                                                                 bigCircleColor: Color(hex: "EDEDED"),
                                                                 smallCircleColor: Color(hex: "9AA987"),
                                                                 textColor: Color(hex: "767676"),
                                                                 buttonColor: Color(hex: "9AA987"),
                                                                 buttonBackground: Color(hex: "FFFFFF")))
}
