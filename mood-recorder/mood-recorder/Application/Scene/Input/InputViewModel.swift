//
//  InputViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import SwiftUI

class InputViewModel: ObservableObject {
    @Published var inputDataModel = InputDataModel.initData()
    @Published var isImagePickerShowing = false

    func onOptionTap(section: Section, optionModel: OptionModel) {
        let psuedoDataModel = inputDataModel
                
        guard let models = psuedoDataModel.visibleSections
                .first(where: {$0.section == section})?
                .cell as? [OptionModel] else { return }
        
        if section == .emotion {
            models.forEach { $0.isSelected = false } 
        }
        
        models.first(where: {$0 == optionModel})?.isSelected.toggle()
        
        withAnimation(.spring()) {
            inputDataModel = psuedoDataModel
        }
    }
    
    func showImagePicker() {
        isImagePickerShowing.toggle()
    }
    
    func onPictureSelected(section: Section, image: UIImage) {
        let psuedoDataModel = inputDataModel
                
        guard let model = psuedoDataModel.visibleSections
                .first(where: {$0.section == section})?
                .cell as? ImageModel else { return }

        model.data = image.jpegData(compressionQuality: 0.5)
        
        withAnimation(.spring()) {
            inputDataModel = psuedoDataModel
        }
    }
}
