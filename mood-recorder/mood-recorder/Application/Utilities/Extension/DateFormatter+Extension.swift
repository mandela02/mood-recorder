//
//  DateFormatter+Extension.swift
//  mood-recorder
//
//  Created by LanNTH on 07/08/2021.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String, localeIdentifier: String = "en-US") {
        self.init()
        self.dateFormat = dateFormat
        self.locale = Locale(identifier: localeIdentifier)
        self.calendar = .gregorian
    }
    
    convenience init(dateFormat: String, locale: Locale) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = locale
        self.calendar = .gregorian
    }
}
