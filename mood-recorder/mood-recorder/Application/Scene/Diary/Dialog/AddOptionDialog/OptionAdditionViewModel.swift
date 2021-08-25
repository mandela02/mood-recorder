//
//  OptionAdditionViewModel.swift
//  OptionAdditionViewModel
//
//  Created by LanNTH on 15/08/2021.
//

import Foundation

class OptionAdditionViewModel: ViewModel {
    
    @Published
    var state: OptionAdditionState
    
    init(state: OptionAdditionState) {
        self.state = state
        self.state.status = self.state.initialSectionModel.section == .custom ? .custom : .normal
        if self.state.status == .custom {
            onCustomCase()
        } else {
            onNormalCase()
        }
        
    }
        
    func onNormalCase() {
        var allModel = state.initialSectionModel
            .section
            .allOptions
            .enumerated()
            .map { OptionModel(content: $1,
                               isSelected: false) }
        
        guard let currentSelectedOptions = state.initialSectionModel.cell as? [OptionModel] else { return }
        for index in allModel.indices {
            let model = allModel[index]
            if currentSelectedOptions.contains(where: {$0.content == model.content}) {
                allModel[index].changeSelectionStatus()
            }
        }
        allModel
            .sort(by: {$0.content.image.rawValue < $1.content.image.rawValue})
                        
        self.state.optionModels = allModel.chunked(into: 15)
        self.state.numberOfPage = self.state.optionModels.count
    }
    
    func onCustomCase() {
        guard var allModels = state.initialSectionModel.cell as? [OptionModel] else { return }
        
        if !allModels.isEmpty {
            for index in allModels.indices {
                allModels[index].visibilitySync()
            }
        }
        
        allModels.append(OptionModel(content: ImageAndTitleModel(image: .systemPlus,
                                                                title: "")))

        self.state.optionModels = allModels.chunked(into: 15)
        self.state.numberOfPage = self.state.optionModels.count
    }
    
    func trigger(_ input: OptionAdditionTrigger) {
        switch input {
        case .optionTap(let optionIndex):
            state.optionModels[state.currentPage][optionIndex]
                .changeSelectionStatus()
            
        case .goToPage(let page):
            state.currentPage = page
            
        case .loadData:
            var allModels = state.optionModels.flatMap({$0})
            var selectedModels = [OptionModel]()
            if self.state.status == .custom {
                allModels.removeLast()
                selectedModels = allModels
            } else {
                selectedModels = allModels
                    .filter({$0.isSelected})
            }
            
            for index in selectedModels.indices {
                selectedModels[index].selectionSync()
                selectedModels[index].isSelected = false
            }

            self.state.outPutModels = selectedModels
            
        case .addData(model: var model):
            let lastIndex = self.state.optionModels.count - 1
            model.isSelected = true
            if self.state.optionModels[lastIndex].count == 15 {
                self.state.optionModels[lastIndex].removeLast()
                self.state.optionModels[lastIndex].append(model)
                self.state.optionModels.append([OptionModel(content: ImageAndTitleModel(image: .systemPlus,
                                                                                        title: ""))])
            } else {
                let index = state.optionModels[lastIndex].endIndex - 1
                self.state.optionModels[lastIndex].insert(model, at: index)
            }
            
            state.numberOfPage = self.state.optionModels.count
            
        case .editStart(model: let model):
            state.selectedModel = model
            
        case .editEnd(model: let model):
            guard let selectedModel = state.selectedModel,
                  let index = state.optionModels[state.currentPage].firstIndex(of: selectedModel) else { return }
            state.optionModels[state.currentPage][index].content = model.content
            state.selectedModel = nil
            
        case .delete(model: let model):
            var allModels = state.optionModels.flatMap({$0})
            guard let index = state.optionModels[state.currentPage].firstIndex(of: model) else { return }
            allModels.remove(at: index)
            self.state.optionModels = allModels.chunked(into: 15)
            self.state.numberOfPage = self.state.optionModels.count
            if state.currentPage == self.state.optionModels.count {
                state.currentPage -= 1
            }
            
        case .clear:
            state.selectedModel = nil
        }
    }
    
    struct OptionAdditionState {
        var initialSectionModel: SectionModel
        
        var optionModels: [[OptionModel]] = []
        var currentPage = 0
        var numberOfPage = 0
        var status = SectionStatus.normal
        
        var outPutModels: [OptionModel] = []
        var selectedModel: OptionModel?
        
        var isCustomSection: Bool {
            return initialSectionModel.section == .custom
        }
    }
    
    enum SectionStatus {
        case normal
        case custom
    }
    
    enum OptionAdditionTrigger {
        case optionTap(optionIndex: Int)
        case goToPage(page: Int)
        case loadData
        case addData(model: OptionModel)
        case editStart(model: OptionModel)
        case editEnd(model: OptionModel)
        case clear
        case delete(model: OptionModel)
    }
}
