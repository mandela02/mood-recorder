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
    @Published var sectionModels: [SectionModel] = []
    
    private let action = PassthroughSubject<InputAction, Never>()
    private let response = PassthroughSubject<DatabaseResponse, Never>()
    
    private var status = Status.new
    
    private let useCase = UseCaseProvider.defaultProvider.getinputUseCase()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        action.send(completion: .finished)
        response.send(completion: .finished)
        
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    init(emotion: CoreEmotion? = nil,
         at date: Date = Date()) {
        setupSubcription()
        initData(with: emotion, at: date)
    }
    
    func onActionHappeded(action: InputAction) {
        self.action.send(action)
    }
    
    private func initData(with emotion: CoreEmotion?, at date: Date) {
        if useCase.isRecordExist(date: date.startOfDayInterval) {
            status = .update(date: date)
            response.send(useCase.fetch(at: date.startOfDayInterval))
        } else {
            self.sectionModels = InputDataModel.initData().sections
        }
        
        if let emotion = emotion {
            for index in sectionModels.indices {
                sectionModels[index].onEmotionSelected(emotion: emotion)
            }
        }
        
        self.sort()
    }
}

// MARK: - Subcription Handler
extension InputViewModel {
    private func setupSubcription() {
        func onDismissKeyboardNeeded() {
            UIApplication.shared.endEditing()
        }
        
        response
            .sink { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(data: let data):
                    if let model = data as? InputDataModel {
                        self.sectionModels = model.sections
                    }
                case .error(error: _):
                    print("error")
                }
                
            }
            .store(in: &cancellables)
        
        action
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                // MARK: - close button tapped
                case .closeButtonTapped:
                    onDismissKeyboardNeeded()
                    
                // MARK: - edit button tapped
                case .editButtonTapped:
                    onDismissKeyboardNeeded()
                    
                    self.isInEditMode.toggle()

                // MARK: - done button tapped
                case .doneButtonTapped:
                    onDismissKeyboardNeeded()
                    let model = InputDataModel(sections: self.sectionModels)
                    switch self.status {
                    case .new:
                        self.response.send(self.useCase.save(model: model))
                    case .update(date: let date):
                        self.response.send(self.useCase.update(at: date.startOfDayInterval,
                                                               model: model))
                    }
                    
                // MARK: - image cell tapped
                case .imageButtonTapped:
                    onDismissKeyboardNeeded()
                    self.isImagePickerShowing.toggle()
                    
                // MARK: - keyboard need dismiss
                case .dismissKeyboard:
                    onDismissKeyboardNeeded()
                    
                // MARK: - cell option tapped
                case .optionTap(sectionModelIndex: let sectionModelIndex,
                                optionModelIndex: let optionModelIndex):
                    onDismissKeyboardNeeded()
                    self.sectionModels[sectionModelIndex].changeOptionSelection(at: optionModelIndex)
                    
                // MARK: - picture selected
                case .pictureSelected(sectionModelIndex: let sectionModelIndex, image: let image):
                    guard var model = self.sectionModels[sectionModelIndex].cell as? ImageModel else { return }
                    model.data = image.jpegData(compressionQuality: 0.5)
                    
                // MARK: - display or hide section
                case .onSectionVisibilityChanged(sectionIndex: let sectionIndex):
                    withAnimation(.default) {
                        self.sectionModels[sectionIndex].changeVisibility()
                    }
                    
                    self.sort()
                }
            }
            .store(in: &cancellables)
    }
    
    private func sort() {
        withAnimation(.easeInOut) {
            var visibles = self.sectionModels.filter { $0.isVisible }
            visibles.sort(by: { $0.section.rawValue < $1.section.rawValue })
            
            var hiddens = self.sectionModels.filter { !$0.isVisible }
            hiddens.sort(by: { $0.section.rawValue < $1.section.rawValue })
            self.sectionModels = visibles + hiddens
        }
    }
}

// MARK: - Private enum
extension InputViewModel {
    private enum Status {
        case new
        case update(date: Date)
    }
    
    enum InputAction {
        case optionTap(sectionModelIndex: Int, optionModelIndex: Int)
        case pictureSelected(sectionModelIndex: Int, image: UIImage)
        case onSectionVisibilityChanged(sectionIndex: Int)
        case closeButtonTapped
        case editButtonTapped
        case doneButtonTapped
        case imageButtonTapped
        case dismissKeyboard
    }
}
