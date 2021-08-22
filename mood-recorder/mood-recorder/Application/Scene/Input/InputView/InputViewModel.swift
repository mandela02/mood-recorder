//
//  InputViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import SwiftUI
import Combine

class InputViewModel: ViewModel {
    
    @Published
    var state: InputState
    
    private let useCase = UseCaseProvider.defaultProvider.getInputUseCases()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    init(state: InputState) {
        self.state = state
        setupSubcription()
        initData(with: state.initialEmotion, or: state.initialData)
    }
    
    func trigger(_ input: InputTrigger) {
        switch input {
        // MARK: - edit button tapped
        case .editButtonTapped:
            self.state.isInEditMode.toggle()

        // MARK: - done button tapped
        case .doneButtonTapped:
            switch self.state.status {
            case .new:
                let model = InputDataModel(date: Date(),
                                           sections: self.state.sectionModels)
                self.state.response.send(self.useCase.save(model: model))
            case .update(date: let date):
                let model = InputDataModel(date: date,
                                           sections: self.state.sectionModels)
                self.state.response.send(self.useCase.update(model: model))
            case .create(date: let date):
                let model = InputDataModel(date: date,
                                           sections: self.state.sectionModels)
                self.state.response.send(self.useCase.save(model: model))
            }
            
        // MARK: - cell option tapped
        case .optionTap(sectionIndex: let sectionIndex,
                        optionIndex: let optionIndex):
            if self.state.isInEditMode { return }
            if state.sectionModels[sectionIndex].section != .custom {
                self.state.sectionModels[sectionIndex]
                    .changeOptionSelection(at: optionIndex)
            } else {
                guard let models = state.sectionModels[sectionIndex].cell as? [OptionModel] else { return }
                let visibleModel = models.filter { $0.isVisible }[optionIndex]
                guard let trueModelIndex = models.firstIndex(of: visibleModel) else { return }
                self.state.sectionModels[sectionIndex]
                    .changeOptionSelection(at: trueModelIndex)
            }
            
        // MARK: - Emotion Selection
        case .emotionSelected(sectionIndex: let sectionIndex, emotion: let emotion):
            self.state.sectionModels[sectionIndex].onEmotionSelected(emotion: emotion)

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
        
        // MARK: - Text change
        case .onTextChange(sectionIndex: let sectionIndex, text: let text):
            self.state.sectionModels[sectionIndex].addText(text: text)
        
        // MARK: - Reset button tap
        case .resetButtonTapped:
            for index in state.sectionModels.indices {
                self.state.sectionModels[index].resetCell()
            }
            
        // MARK: - Select Section
        case .onOpenCustomizeSectionDialog(model: let model):
            state.selectedSectionModel = model
            
        // MARK: - custom Section
        case .onCustomSection(models: var models):
            guard let options = state.selectedSectionModel?.cell as? [OptionModel]
            else { return }
            
            guard let sectionIndex = state.sectionModels.firstIndex(where: {$0.id == state.selectedSectionModel?.id})
            else { return }
            
            for index in models.indices {
                guard let model = options.first(where: {$0.content == models[index].content})
                else { continue }
                models[index].isSelected = model.isSelected
            }
            
            state.sectionModels[sectionIndex].cell = models
            
        // MARK: - Select Sleep Schedule
        case .onSleepScheduleChange(bedTime: let bedTime, wakeUpTime: let wakeUpTime):
            guard let sectionIndex = state.sectionModels.firstIndex(where: {$0.id == state.selectedSectionModel?.id})
            else { return }
            self.state.sectionModels[sectionIndex].addSleepScheldule(bedTime: bedTime, wakeUpTime: wakeUpTime)
        case .handleDismissDialog(status: let status):
            state.isAboutToDismiss = status == .open
        case .handleResetDialog(status: let status):
            state.isAboutToReset = status == .open
        case .handleCustomDialog(status: let status):
            state.isAboutToCustomizeSection = status == .open
        case .handleTimeDialog(status: let status):
            state.isAboutToShowTimePicker = status == .open
        }
    }
        
    private func initData(with emotion: CoreEmotion?,
                          or data: InputDataModel?) {
        if let data = data {
            if data.sections.isEmpty {
                state.status = .create(date: data.date)
                state.sectionModels = InputDataModel.initData().sections
            } else {
                state.status = .update(date: data.date)
                state.sectionModels = data.sections
            }
        } else {
            if useCase.isRecordExist(date: Date().startOfDayInterval) {
                state.status = .update(date: Date())
                state.response.send(useCase.fetch(at: Date().startOfDayInterval))
            } else {
                state.status = .new
                state.sectionModels = InputDataModel.initData().sections
            }
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
                case .error(error: let error):
                    print(error)
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
        case emotionSelected(sectionIndex: Int, emotion: CoreEmotion)
        case onSectionVisibilityChanged(section: SectionType)
        case onTextChange(sectionIndex: Int, text: String)
        case onSleepScheduleChange(bedTime: Int, wakeUpTime: Int)
        case onOpenCustomizeSectionDialog(model: SectionModel?)
        case onCustomSection(models: [OptionModel])
        case editButtonTapped
        case doneButtonTapped
        case resetButtonTapped
        case handleDismissDialog(status: ViewStatus)
        case handleResetDialog(status: ViewStatus)
        case handleCustomDialog(status: ViewStatus)
        case handleTimeDialog(status: ViewStatus)

        enum ViewStatus {
            case open
            case close
        }
    }
    
    struct InputState {
        var initialEmotion: CoreEmotion?
        var initialData: InputDataModel?

        var isInEditMode = false
        var isAboutToDismiss = false
        var isAboutToCustomizeSection = false
        var isAboutToReset = false
        var isAboutToShowTimePicker = false

        var sectionModels: [SectionModel] = []
        
        var selectedSectionModel: SectionModel?

        let response = PassthroughSubject<DatabaseResponse, Never>()
        
        var status = Status.new
        
        init(emotion: CoreEmotion? = nil, data: InputDataModel? = nil) {
            self.initialData = data
            self.initialEmotion = emotion
        }

        enum Status {
            case new
            case create(date: Date)
            case update(date: Date)
        }
    }
}
