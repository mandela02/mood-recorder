//
//  OptionModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

class OptionModel: Equatable, Identifiable {
    static func == (lhs: OptionModel, rhs: OptionModel) -> Bool {
        lhs.id == rhs.id
    }
    
    init(content: ImageAndTitleModel, optionID: Int) {
        self.content = content
        self.optionID = optionID
    }
    
    let id = UUID()
    
    let optionID: Int
    let content: ImageAndTitleModel
    
    var isSelected: Bool = false
}
