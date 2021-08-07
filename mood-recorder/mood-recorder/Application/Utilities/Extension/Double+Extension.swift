//
//  Int+Extension.swift
//  mood-recorder
//
//  Created by LanNTH on 07/08/2021.
//

import Foundation

extension Double {
    var date: Date? {
        return Date(timeIntervalSince1970: self)
    }
}
