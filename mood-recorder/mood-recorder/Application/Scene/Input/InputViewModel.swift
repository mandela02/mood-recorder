//
//  InputViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import SwiftUI
import Combine

class InputViewModel: ViewModel {
    @Published var state: InputState
    
    private let useCase = UseCaseProvider.defaultProvider.getinputUseCase()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    init(state: InputState) {
        self.state = state
        setupSubcription()
        initData(with: state.initialEmotion, at: state.initialDate)
    }
    
    func trigger(_ input: InputTrigger) {
        switch input {
        // MARK: - edit button tapped
        case .editButtonTapped:
            self.state.isInEditMode.toggle()

        // MARK: - done button tapped
        case .doneButtonTapped:
            let model = InputDataModel(sections: self.state.sectionModels)
            switch self.state.status {
            case .new:
                self.state.response.send(self.useCase.save(model: model))
            case .update(date: let date):
                self.state.response.send(self.useCase.update(at: date.startOfDayInterval,
                                                       model: model))
            }
            
        // MARK: - cell option tapped
        case .optionTap(sectionIndex: let sectionIndex,
                        optionIndex: let optionIndex):
            if self.state.isInEditMode { return }
            self.state.sectionModels[sectionIndex]
                .changeOptionSelection(at: optionIndex)
            
        // MARK: - picture selected
        case .pictureSelected(sectionIndex: let sectionIndex, image: let image):
            self.state.sectionModels[sectionIndex].addImage(image: image)
            
        // MARK: - display or hide section
        case .onSectionVisibilityChanged(section: let section):
            guard let index = self.state.sectionModels.firstIndex(where: {$0.section == section}) else { return }
            
            self.state.sectionModels[index].changeVisibility()
            
            if !self.state.sectionModels[index].isVisible {
                self.state.sectionModels[index].resetCell()
            }
            
            self.sort()
        
        // MARK: - text change
        case .onTextChange(sectionIndex: let sectionIndex, text: let text):
            self.state.sectionModels[sectionIndex].addText(text: text)
        
        case .resetButtonTapped:
            for index in state.sectionModels.indices {
                self.state.sectionModels[index].resetCell()
            }
        }
    }
        
    private func initData(with emotion: CoreEmotion?, at date: Date) {
        if useCase.isRecordExist(date: date.startOfDayInterval) {
            state.status = .update(date: date)
            state.response.send(useCase.fetch(at: date.startOfDayInterval))
        } else {
            state.sectionModels = InputDataModel.initData().sections
        }
        
        if let emotion = emotion {
            for index in state.sectionModels.indices {
                state.sectionModels[index].onEmotionSelected(emotion: emotion)
            }
        }
        
        self.sort()
    }
}

// MARK: - Subcription Handler
extension InputViewModel {
    private func setupSubcription() {
        self.state.response
            .sink { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(data: let data):
                    if let model = data as? InputDataModel {
                        self.state.sectionModels = model.sections
                        self.sort()
                    }
                case .error(error: _):
                    print("error")
                }
                
            }
            .store(in: &cancellables)
    }
    
    private func sort() {
        var visibles = self.state.sectionModels.filter { $0.isVisible }
        visibles.sort(by: { $0.section.rawValue < $1.section.rawValue })
        
        var hiddens = self.state.sectionModels.filter { !$0.isVisible }
        hiddens.sort(by: { $0.section.rawValue < $1.section.rawValue })
        
        self.state.sectionModels = visibles + hiddens
    }
}

// MARK: - Private enum
extension InputViewModel {
    enum InputTrigger {
        case optionTap(sectionIndex: Int, optionIndex: Int)
        case pictureSelected(sectionIndex: Int, image: UIImage)
        case onSectionVisibilityChanged(section: SectionType)
        case onTextChange(sectionIndex: Int, text: String)
        case editButtonTapped
        case doneButtonTapped
        case resetButtonTapped
    }
    
    struct InputState {
        var initialEmotion: CoreEmotion?
        var initialDate: Date

        var isInEditMode = false
        var sectionModels: [SectionModel] = []

        let response = PassthroughSubject<DatabaseResponse, Never>()
        
        var status = Status.new
        
        init(emotion: CoreEmotion? = nil, date: Date = Date()) {
            self.initialDate = date
            self.initialEmotion = emotion
        }

        enum Status {
            case new
            case update(date: Date)
        }
    }
}
