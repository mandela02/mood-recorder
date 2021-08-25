//
//  DiaryViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import SwiftUI
import Combine

class DiaryViewModel: ViewModel {
    
    @Published
    var state: DiaryState
    
    private let useCase = UseCaseProvider.defaultProvider.getDiaryUseCases()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
    }
    
    init(state: DiaryState) {
        self.state = state
    }
    
    func trigger(_ input: DiaryTrigger) {
        switch input {
        // MARK: - init data
        case .initialSectionModels:
            initData(with: state.initialEmotion, or: state.initialData)
        // MARK: - edit button tapped
        case .editButtonTapped:
            if state.diaryViewState == .normal {
                state.diaryViewState = .edit
            } else {
                state.diaryViewState = .normal
            }

        // MARK: - done button tapped
        case .finishThisDiary:
            switch self.state.status {
            case .new:
                let model = DiaryDataModel(date: Date(),
                                           sections: self.state.sectionModels)
                let response = self.useCase.save(model: model)
                syncFetchSingleResponse(response: response, emotion: nil)
            case .update(date: let date):
                let model = DiaryDataModel(date: date,
                                           sections: self.state.sectionModels)
                let response = self.useCase.update(model: model)
                syncFetchSingleResponse(response: response, emotion: nil)
            case .create(date: let date):
                let model = DiaryDataModel(date: date,
                                           sections: self.state.sectionModels)
                let response = self.useCase.save(model: model)
                syncFetchSingleResponse(response: response, emotion: nil)
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
            
            self.syncSort(emotion: nil)
        
        // MARK: - Text change
        case .onTextChange(sectionIndex: let sectionIndex, text: let text):
            self.state.sectionModels[sectionIndex].addText(text: text)
        
        // MARK: - Reset button tap
        case .resetAllData:
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
        case .inittialData(data: let data):
            state.initialData = data
        case .initialEmotion(emotion: let emotion):
            state.initialEmotion = emotion
        case .clear:
            self.state = DiaryState()
        }
    }
        
    private func initData(with emotion: CoreEmotion?,
                          or data: DiaryDataModel?) {
        if let data = data {
            if data.sections.isEmpty {
                state.status = .create(date: data.date)
                state.sectionModels = DiaryDataModel.initData().sections
                self.syncSort(emotion: emotion)
            } else {
                state.status = .update(date: data.date)
                state.sectionModels = data.sections
                self.syncSort(emotion: emotion)
            }
        } else {
            if useCase.isRecordExist(date: Date().startOfDayInterval) {
                state.status = .update(date: Date())
                let response = useCase.fetch(at: Date().startOfDayInterval)
                syncFetchSingleResponse(response: response, emotion: nil)
            } else {
                state.status = .new
                state.sectionModels = DiaryDataModel.initData().sections
                self.syncSort(emotion: emotion)
            }
        }
    }
}

// MARK: - Subcription Handler
extension DiaryViewModel {
    private func syncSort(emotion: CoreEmotion?) {
        Task {
            await sort(models: state.sectionModels, emotion: emotion)
        }
    }
    
    private func syncFetchSingleResponse(response: DatabaseResponse, emotion: CoreEmotion?) {
        Task {
            await fetch(responses: response, emotion: emotion)
        }
    }
    
    private func fetch(responses: DatabaseResponse..., emotion: CoreEmotion?) async {
        if responses.count != 1 { return }

        do {
            let result = try await handleResponse(response: responses[0])
            if let result = result as? DiaryDataModel {
                await sort(models: result.sections, emotion: emotion)
            }
        } catch let error {
            print(error)
        }
        
    }

    private func handleResponse(response: DatabaseResponse) async throws -> Any? {
        switch response {
        case .success(data: let data):
            if let data = data {
                return data
            }
            return nil
        case .error(error: let error):
            throw error
        }
    }
    
    private func sort(models: [SectionModel], emotion: CoreEmotion?) async {
        let task = Task(priority: .userInitiated) { () -> [SectionModel] in
            var mutatedModels = models
            
            var visibles = mutatedModels.filter { $0.isVisible }
            
            if let emotion = emotion {
                for index in models.indices {
                    mutatedModels[index].onEmotionSelected(emotion: emotion)
                }
            }
            
            visibles.sort(by: { $0.section.rawValue < $1.section.rawValue })
            
            var hiddens = mutatedModels.filter { !$0.isVisible }
            hiddens.sort(by: { $0.section.rawValue < $1.section.rawValue })
            
            return visibles + hiddens
        }
        
        let result = await task.value
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state.sectionModels = result
            self.state.diaryViewState = .normal
        }
    }
}

// MARK: - Private enum
extension DiaryViewModel {
    enum DiaryTrigger {
        case optionTap(sectionIndex: Int, optionIndex: Int)
        case pictureSelected(sectionIndex: Int, image: UIImage)
        case emotionSelected(sectionIndex: Int, emotion: CoreEmotion)
        case onSectionVisibilityChanged(section: SectionType)
        case onTextChange(sectionIndex: Int, text: String)
        case onSleepScheduleChange(bedTime: Int, wakeUpTime: Int)
        case onOpenCustomizeSectionDialog(model: SectionModel?)
        case onCustomSection(models: [OptionModel])
        case editButtonTapped
        case finishThisDiary
        case resetAllData
        case handleDismissDialog(status: ViewStatus)
        case handleResetDialog(status: ViewStatus)
        case handleCustomDialog(status: ViewStatus)
        case handleTimeDialog(status: ViewStatus)
        case initialSectionModels
        case inittialData(data: DiaryDataModel?)
        case initialEmotion(emotion: CoreEmotion?)
        case clear
    }
    
    enum ViewStatus {
        case open
        case close
    }
    
    enum DiaryViewState {
        case loading
        case normal
        case edit
    }
    
    struct DiaryState {
        var initialEmotion: CoreEmotion?
        var initialData: DiaryDataModel?

        var diaryViewState = DiaryViewState.loading
        
        var isAboutToDismiss = false
        var isAboutToCustomizeSection = false
        var isAboutToReset = false
        var isAboutToShowTimePicker = false

        var sectionModels: [SectionModel] = []
        
        var selectedSectionModel: SectionModel?
        
        var status = Status.new
        
        var isInEditMode: Bool {
            return diaryViewState == .edit
        }
        
        var isInLoadingMode: Bool {
            return diaryViewState == .loading
        }
    }
    
    enum Status {
        case new
        case create(date: Date)
        case update(date: Date)
    }
}
