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
    
    static func post(themeId: Int) {
        Settings.themeId.value = themeId
    }
    
    static func get(id: Int) -> ThemeColor {
        return Theme.allCases[safe: id]?.themeColor ?? Theme.lightMode.themeColor
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
        var redColor: Color
    }
    
    struct CommonColor {
        var textColor: Color
        var textBackground: Color
        var viewBackground: Color
        var dialogBackground: Color
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
    let colorScheme: ColorScheme
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
                                                                 disableColor: Color(hex: "EDEDED"),
                                                                 redColor: Color(hex: "800000")),
                                        commonColor: CommonColor(textColor: Color(hex: "767676"),
                                                                 textBackground: Color(hex: "EDEDED"),
                                                                 viewBackground: Color(hex: "F5FAF4"),
                                                                 dialogBackground: Color(hex: "FFFFFF")),
                                        sleepColor: SleepColor(backgroundColor: Color(hex: "F5FAF4"),
                                                               bigCircleColor: Color(hex: "EDEDED"),
                                                               smallCircleColor: Color(hex: "9AA987"),
                                                               textColor: Color(hex: "767676"),
                                                               buttonColor: Color(hex: "9AA987"),
                                                               buttonBackground: Color(hex: "FFFFFF")),
                                        colorScheme: .light)
    
    static let momotoneBlack = ThemeColor(navigationColor: NavigationColor(button: Color(hex: "F1F2F2"),
                                                                           title: Color(hex: "F1F2F2"),
                                                                           background: Color(hex: "FFB30A")),
                                          tableViewColor: TableViewColor(background: Color(hex: "000000"),
                                                                         cellBackground: Color(hex: "17191A"),
                                                                         text: Color(hex: "F1F2F2")),
                                          buttonColor: ButtonColor(backgroundColor: Color(hex: "FFB30A"),
                                                                   textColor: Color(hex: "F1F2F2"),
                                                                   iconColor: Color(hex: "F1F2F2"),
                                                                   disableColor: Color(hex: "555555"),
                                                                   redColor: Color(hex: "800000")),
                                          commonColor: CommonColor(textColor: Color(hex: "F1F2F2"),
                                                                   textBackground: Color(hex: "555555"),
                                                                   viewBackground: Color(hex: "000000"),
                                                                   dialogBackground: Color(hex: "18191A")),
                                          sleepColor: SleepColor(backgroundColor: Color(hex: "18191A"),
                                                                 bigCircleColor: Color(hex: "1C1D1D"),
                                                                 smallCircleColor: Color(hex: "FFB30A"),
                                                                 textColor: Color(hex: "FFB30A"),
                                                                 buttonColor: Color(hex: "FFB30A"),
                                                                 buttonBackground: Color(hex: "1C1D1D")),
                                          colorScheme: .dark)
}
