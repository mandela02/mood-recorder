//
//  SectionModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation
import UIKit

struct SectionModel: Identifiable, Equatable {
    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(section: SectionType, title: String, cell: Any?, isEditable: Bool = true, isVisible: Bool = true) {
        self.section = section
        self.title = title
        self.cell = cell
        self.isEditable = isEditable
        self.isVisible = isVisible
    }
    
    let id = UUID()
    
    let section: SectionType
    let title: String
    
    var cell: Any?
    
    var isVisible: Bool = true
    var isEditable: Bool = true
    
    mutating func changeVisibility() {
        isVisible.toggle()
    }
    
    mutating func changeOptionSelection(at index: Int) {
        guard var options = cell as? [OptionModel] else {
            return
        }
        
        if section == .emotion {
            for i in options.indices {
                options[i].isSelected = false
            }
        }
        
        options[index].changeSelectionStatus()
        
        cell = options
    }
    
    mutating func onEmotionSelected(emotion: CoreEmotion) {
        guard var options = cell as? [OptionModel] else {
            return
        }
        
        if section == .emotion {
            for i in options.indices {
                options[i].isSelected = options[i].content.image == emotion.imageName
            }
            
            cell = options
        }
    }
    
    mutating func addImage(image: UIImage) {
        guard var model = cell as? ImageModel else {
            return
        }
        model.data = image.jpegData(compressionQuality: 0.25)
        cell = model
    }
    
    mutating func addText(text: String) {
        guard var model = cell as? TextModel else {
            return
        }
        model.text = text
        cell = model
    }
}
