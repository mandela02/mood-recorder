//
//  InputViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import Foundation

class InputViewModel: ObservableObject {
    @Published var inputDataModel = InputDataModel.initData()
    
    init() {    }
    
    func onOptionTap(section: Section, optionModel: OptionModel) {
        guard let models = inputDataModel.visibleSections
                .first(where: {$0.section == section})?
                .cell as? [OptionModel] else { return }
        
        models.first(where: {$0 == optionModel})?.isSelected.toggle()
    }
}
