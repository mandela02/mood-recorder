//
//  OptionModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

struct OptionModel: Equatable, Identifiable {
    static func == (lhs: OptionModel, rhs: OptionModel) -> Bool {
        lhs.id == rhs.id
    }
    
    init(content: ImageAndTitleModel, optionID: Int, isSelected: Bool = false) {
        self.content = content
        self.optionID = optionID
        self.isSelected = isSelected
    }
    
    let id = UUID()
    
    let optionID: Int
    let content: ImageAndTitleModel
    
    var isSelected: Bool = false
    
    mutating func changeSelectionStatus() {
        isSelected.toggle()
    }
}
