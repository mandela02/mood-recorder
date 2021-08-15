//
//  OptionModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

struct OptionModel: Equatable, Identifiable, Hashable {
    static func == (lhs: OptionModel, rhs: OptionModel) -> Bool {
        lhs.id == rhs.id || lhs.content == rhs.content
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(content: ImageAndTitleModel, isSelected: Bool = false) {
        self.content = content
        self.isSelected = isSelected
    }
    
    let id = UUID()
    
    let content: ImageAndTitleModel
    
    var isSelected: Bool = false
    
    mutating func changeSelectionStatus() {
        isSelected.toggle()
    }
}
