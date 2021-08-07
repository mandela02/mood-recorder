//
//  InputViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import SwiftUI
import Combine

class InputViewModel: ObservableObject {
    @Published var isImagePickerShowing = false
    @Published var text = ""
    @Published var isInEditMode = false
    
    @Published var inputDataModel = InputDataModel.initData()

    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    private func setState(_ change:() -> ()) {
        change()
        withAnimation(.easeInOut) {
            let psuedoData = inputDataModel
            
            var visibles = psuedoData.sections.filter { $0.isVisible }
            visibles.sort(by: { $0.section.rawValue < $1.section.rawValue })
            
            var hiddens = psuedoData.sections.filter { !$0.isVisible }
            hiddens.sort(by: { $0.section.rawValue < $1.section.rawValue })

            psuedoData.sections = visibles + hiddens
            
            inputDataModel = psuedoData
        }
    }

    func onOptionTap(sectionModel: SectionModel, optionModel: OptionModel) {
        setState {
            guard let models = sectionModel.cell as? [OptionModel] else { return }
            
            if sectionModel.section == .emotion {
                models.forEach { $0.isSelected = false }
            }
            
            optionModel.isSelected.toggle()
        }
    }
    
    func showImagePicker() {
        isImagePickerShowing.toggle()
    }
    
    func onPictureSelected(sectionModel: SectionModel, image: UIImage) {
        setState {
            guard let model = sectionModel.cell as? ImageModel else { return }

            model.data = image.jpegData(compressionQuality: 0.5)
        }
    }
    
    func onSectionDismiss(sectionModel: SectionModel) {
        setState {
            sectionModel.isVisible.toggle()
        }
    }
    
    func onCloseButtonTapped() {
        if isInEditMode {
            changeMode()
        }
    }
    
    func onEditButtonTapped() {
        changeMode()
    }
    
    private func changeMode() {
        withAnimation(.spring()) {
            isInEditMode.toggle()
        }
    }
}
