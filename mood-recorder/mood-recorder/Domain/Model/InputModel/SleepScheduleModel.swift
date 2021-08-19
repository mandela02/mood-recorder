//
//  SleepScheduleModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

struct SleepSchelduleModel {
    init(bedTime: String? = nil, wakeUpTime: String? = nil) {
        self.bedTime = bedTime
        self.wakeUpTime = wakeUpTime
    }
    
    var bedTime: String?
    var wakeUpTime: String?
    
    var isHavingNilData: Bool {
        bedTime == nil && wakeUpTime == nil
    }
    
    var displayString: String {
        guard let bedTime = bedTime,
                let bedTimeValue = Int(bedTime),
                let wakeUpTime = wakeUpTime,
                let wakeUpTimeValue = Int(wakeUpTime)
        else {
            return "Select today sleep schedule"
        }
        return bedTimeValue.generateHourMinuteString() + " : " + wakeUpTimeValue.generateHourMinuteString()
    }
}
