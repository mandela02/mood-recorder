//
//  SleepScheduleModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

class SleepSchelduleModel {
    init(startTime: Int? = nil, endTime: Int? = nil) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var startTime: Int?
    var endTime: Int?
}
