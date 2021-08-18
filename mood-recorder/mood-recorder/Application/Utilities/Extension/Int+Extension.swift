//
//  Int+Extension.swift
//  Int+Extension
//
//  Created by TriBQ on 8/18/21.
//

import Foundation

extension Int {
    private func minutesToHoursAndMinutes() -> (hours: Int,
                                                leftMinutes : Int) {
        return (self / 60, (self % 60))
    }
    
    
    func generateHourMinuteString() -> String {
        let hourMinute = minutesToHoursAndMinutes()
        var string = ""
        string.append(contentsOf: hourMinute.hours < 10 ? "0\(hourMinute.hours)" : "\(hourMinute.hours)")
        string.append(contentsOf: ":")
        string.append(contentsOf: hourMinute.leftMinutes < 10 ? "0\(hourMinute.leftMinutes)" : "\(hourMinute.leftMinutes)")
        return string
    }
}
