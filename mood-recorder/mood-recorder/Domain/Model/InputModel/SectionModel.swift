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
        if cell is CoreEmotion {
            cell = emotion
        }
    }
    
    mutating func addImage(image: UIImage) {
        guard var model = cell as? ImageModel else {
            return
        }
        
        let newImage = image
            .resizeImage(targetSize: CGSize(width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.width *
                                            image.size.height / image.size.width))
        
        model.data = newImage.jpegData(compressionQuality: 1)
        cell = model
    }
    
    mutating func addText(text: String) {
        guard var model = cell as? TextModel else {
            return
        }
        model.text = text
        cell = model
    }
    
    mutating func addSleepScheldule(bedTime: Int, wakeUpTime: Int) {
        guard var model = cell as? SleepSchelduleModel else { return }
        model.wakeUpTime = "\(wakeUpTime)"
        model.bedTime = "\(bedTime)"
        cell = model
    }
    
    mutating func resetCell() {
        var mutatingModel: Any
        
        switch cell {
        case var models as [OptionModel]:
            if section == .emotion {
                return
            }
            
            for i in models.indices {
                models[i].isSelected = false
            }
            
            mutatingModel = models
        case var model as ImageModel:
            model.data = nil
            mutatingModel = model
        case var model as TextModel:
            model.text = nil
            mutatingModel = model
        case var model as SleepSchelduleModel:
            model.bedTime = nil
            model.wakeUpTime = nil
            mutatingModel = model
        default:
            return
        }
        
        cell = mutatingModel
    }
}
