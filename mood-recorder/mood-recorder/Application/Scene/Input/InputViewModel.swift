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
    
    @Published var visibleSections: [SectionModel] = []
    @Published var hiddenSections: [SectionModel] = []

    var inputDataModel = CurrentValueSubject<InputDataModel, Never>(InputDataModel.initData())

    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }

    init() {
        inputDataModel.sink { [weak self] model in
            guard let self = self else { return }
            self.visibleSections = model.sections.filter { $0.isVisible }
            self.hiddenSections = model.sections.filter { !$0.isVisible }
        }
        .store(in: &cancellables)
    }
    
    private func setState(_ change:() -> ()) {
        let psuedoDataModel = inputDataModel.value
        change()
        withAnimation(.spring()) {
            inputDataModel.send(psuedoDataModel)
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
    
    func onPictureSelected(section: Section, image: UIImage) {
        setState {
            guard let model = visibleSections
                    .first(where: {$0.section == section})?
                    .cell as? ImageModel else { return }

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
