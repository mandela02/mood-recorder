//
//  OptionAdditionViewModel.swift
//  OptionAdditionViewModel
//
//  Created by LanNTH on 15/08/2021.
//

import Foundation

class OptionAdditionViewModel: ViewModel {
    @Published var state: OptionAdditionState
    
    init(state: OptionAdditionState) {
        self.state = state
        
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
                
        if state.initialSectionModel.section == .custom {
            allModel.append(OptionModel(content: ImageAndTitleModel(image: .systemPlus,
                                                                    title: "")))
        }
        
        self.state.optionModels = allModel.chunked(into: 15)
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
            let allModels = state.optionModels.flatMap({$0})

            var selectedModels = allModels
                .filter({$0.isSelected})
            
            for index in selectedModels.indices {
                selectedModels[index].isSelected = false
            }

            self.state.outPutModels = selectedModels
        case .addData(model: let model):
            let lastIndex = self.state.optionModels.count - 1
            if self.state.optionModels[lastIndex].count == 15 {
                self.state.optionModels.append([model])
                self.state.currentPage += 1
            } else {
                self.state.optionModels[lastIndex].insert(model, at: 0)
            }
        }
    }
    
    struct OptionAdditionState {
        var initialSectionModel: SectionModel
        
        var optionModels: [[OptionModel]] = []
        var currentPage = 0
        var numberOfPage = 0
        
        var outPutModels: [OptionModel] = []
    }
    
    enum OptionAdditionTrigger {
        case optionTap(optionIndex: Int)
        case goToPage(page: Int)
        case loadData
        case addData(model: OptionModel)
    }
}
