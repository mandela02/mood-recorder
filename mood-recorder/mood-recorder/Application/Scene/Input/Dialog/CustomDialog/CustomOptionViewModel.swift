//
//  CustomOptionViewModel.swift
//  CustomOptionViewModel
//
//  Created by LanNTH on 16/08/2021.
//

import Foundation

class CustomOptionViewModel: ViewModel {
    
    @Published
    var state: CustomOptionState
    
    init(state: CustomOptionState) {
        self.state = state
        
        if let option = state.initialOptionModel {
            self.state.selectedImage = option.content.image
            self.state.title = option.content.title
        }
        
        var allImage = AppImage.allCases
        allImage.removeLast()

        self.state.images = allImage
            .chunked(into: 20)
        self.state.numberOfPage = self.state.images.count
    }
    
    func trigger(_ input: CustomOptionTrigger) {
        switch input {
        case .optionTap(index: let index):
            state.selectedImage = state.images[state.currentPage][index]
        case .goToPage(page: let page):
            self.state.currentPage = page
        case .textChange(text: let text):
            state.title = text
        case .loadData:
            guard let title = state.title,
                  title != "",
                  let image = state.selectedImage
            else {
                return
            }
            let content = ImageAndTitleModel(image: image,
                                             title: title)
            state.outputModel = OptionModel(content: content,
                                            isSelected: true)
        }
    }
    
    struct CustomOptionState {
        var initialOptionModel: OptionModel?
        
        var images: [[AppImage]] = []
        var currentPage = 0
        var numberOfPage = 0
        
        var selectedImage: AppImage?
        var title: String?
        
        var outputModel: OptionModel?
        
        var isSaveEnable: Bool {
            return title != nil && title != "" && selectedImage != nil
        }
        
        var isInEditMode: Bool {
            return initialOptionModel != nil
        }
    }
    
    enum CustomOptionTrigger {
        case optionTap(index: Int)
        case textChange(text: String)
        case goToPage(page: Int)
        case loadData
    }
}

