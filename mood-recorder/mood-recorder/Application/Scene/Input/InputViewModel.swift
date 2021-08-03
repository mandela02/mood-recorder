//
//  InputViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import SwiftUI

class InputViewModel: ObservableObject {
    @Published var inputDataModel = InputDataModel.initData()
        
    func onOptionTap(section: Section, optionModel: OptionModel) {
        let psuedoDataModel = inputDataModel
                
        guard let models = psuedoDataModel.visibleSections
                .first(where: {$0.section == section})?
                .cell as? [OptionModel] else { return }
        
        if section == .emotion {
            models.forEach { $0.isSelected = false } 
        }
        
        models.first(where: {$0 == optionModel})?.isSelected.toggle()
        
        withAnimation(.spring()) {
            inputDataModel = psuedoDataModel
        }
    }
}
