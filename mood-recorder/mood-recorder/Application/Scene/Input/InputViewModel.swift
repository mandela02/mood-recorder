//
//  InputViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 03/08/2021.
//

import Foundation

class InputViewModel: ObservableObject {
    @Published var inputDataModel = InputDataModel.initData()
    
    func onOptionTap(section: Section, optionModel: OptionModel) {
        
    }
}
