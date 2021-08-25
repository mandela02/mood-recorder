//
//  SafeContentModel.swift
//  SafeContentModel
//
//  Created by TriBQ on 8/24/21.
//

import Foundation

struct SafeContentModel {
    var emotion: Double
    var bedTime: String?
    var wakeUpTime: String?
    var image: Data?
    var text: String?
    var options: [SafeOptionModel]
}
