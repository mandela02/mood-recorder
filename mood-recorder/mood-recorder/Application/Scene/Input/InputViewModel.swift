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
    
    private let action = PassthroughSubject<InputAction, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        action.send(completion: .finished)
        
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    init() {
        setupSubcription()
    }
    
    func onActionHappeded(action: InputAction) {
        self.action.send(action)
    }
}

// MARK: - Subcription Handler
extension InputViewModel {
    private func setupSubcription() {
        action
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .optionTap(sectionModel: let sectionModel,
                                optionModel: let optionModel):
                    self.onDismissKeyboardNeeded()
                    self.onOptionTap(at: sectionModel,
                                     with: optionModel)
                case .pictureSelected(sectionModel: let sectionModel,
                                      image: let image):
                    self.onPictureSelected(at: sectionModel,
                                           with: image)
                case .onSectionStatusChanged(sectionModel: let sectionModel):
                    self.onSectionStatusChanged(at: sectionModel)
                case .closeButtonTapped:
                    self.onDismissKeyboardNeeded()
                    self.onCloseButtonTapped()
                case .editButtonTapped:
                    self.onDismissKeyboardNeeded()
                    self.changeViewStatus()
                case .doneButtonTapped:
                    self.onDismissKeyboardNeeded()
                    self.onDoneButtonTapped()
                case .imageButtonTapped:
                    self.onDismissKeyboardNeeded()
                    self.showImagePicker()
                case .dismissKeyboard:
                    self.onDismissKeyboardNeeded()
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Apply data change handler
extension InputViewModel {
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
}

// MARK: - Action handler
extension InputViewModel {
    private func onOptionTap(at sectionModel: SectionModel, with optionModel: OptionModel) {
        setState {
            guard let models = sectionModel.cell as? [OptionModel] else { return }
            
            if sectionModel.section == .emotion {
                models.forEach { $0.isSelected = false }
            }
            
            optionModel.isSelected.toggle()
        }
    }
    
    private func showImagePicker() {
        isImagePickerShowing.toggle()
    }
    
    private func onPictureSelected(at sectionModel: SectionModel, with image: UIImage) {
        setState {
            guard let model = sectionModel.cell as? ImageModel else { return }

            model.data = image.jpegData(compressionQuality: 0.5)
        }
    }
    
    private func onSectionStatusChanged(at sectionModel: SectionModel) {
        setState {
            sectionModel.isVisible.toggle()
        }
    }
    
    private func onCloseButtonTapped() {
        if isInEditMode {
            changeViewStatus()
            return
        }
    }
    
    private func onEditButtonTapped() {
        changeViewStatus()
    }
    
    private func changeViewStatus() {
        withAnimation(.easeInOut) {
            isInEditMode.toggle()
        }
    }
    
    private func onDoneButtonTapped() {
        if isInEditMode {
            changeViewStatus()
            return
        }
    }
    
    private func onDismissKeyboardNeeded() {
        UIApplication.shared.endEditing()
    }
}


// MARK: - Input Action Enum
enum InputAction {
    case optionTap(sectionModel: SectionModel, optionModel: OptionModel)
    case pictureSelected(sectionModel: SectionModel, image: UIImage)
    case onSectionStatusChanged(sectionModel: SectionModel)
    case closeButtonTapped
    case editButtonTapped
    case doneButtonTapped
    case imageButtonTapped
    case dismissKeyboard
}
