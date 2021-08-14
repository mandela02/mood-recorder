//
//  SleepScheduleModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

struct SleepSchelduleModel {
    init(startTime: Double? = nil, endTime: Double? = nil) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var startTime: Double?
    var endTime: Double?
    
    var isHavingNilData: Bool {
        startTime == nil && endTime == nil
    }
    
    var hourString: String {
        return "\(startTime?.date?.hourString ?? "00:00") - \(endTime?.date?.hourString ?? "00:00")"
    }
}
