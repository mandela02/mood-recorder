//
//  Settings.swift
//  Settings
//
//  Created by TriBQ on 8/22/21.
//

import Foundation

struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(key: Keys, defaultValue: T) {
        self.key = key.rawValue
        self.defaultValue = defaultValue
    }
    
    var value: T {
        get {
            if let value = UserDefaults.standard.object(forKey: key) as? T {
                return value
            } else {
                UserDefaults.standard.set(defaultValue, forKey: key)
                UserDefaults.standard.synchronize()
                return defaultValue
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

enum Keys: String {
    case isUsingPasscode
    case themeId
    case isUsingSystemTheme
}

struct Settings {
    static var isUsingPasscode = UserDefault<Bool>(key: .isUsingPasscode,
                                                   defaultValue: false)
    static var isUsingSystemTheme = UserDefault<Bool>(key: .isUsingSystemTheme,
                                                   defaultValue: false)
    static var themeId = UserDefault<Int>(key: .themeId,
                                          defaultValue: 0)
}
