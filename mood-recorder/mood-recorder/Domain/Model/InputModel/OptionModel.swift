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
    
    init(content: ImageAndTitleModel) {
        self.content = content
    }
    
    let id = UUID()
    
    let content: ImageAndTitleModel
    
    var isVisible: Bool = true
    var isSelected: Bool = false
}
