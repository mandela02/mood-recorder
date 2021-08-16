//
//  CustomOptionViewModel.swift
//  CustomOptionViewModel
//
//  Created by LanNTH on 16/08/2021.
//

import Foundation

class CustomOptionViewModel: ViewModel {
    @Published var state: CustomOptionState
    
    init(state: CustomOptionState) {
        self.state = state
        
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
        var images: [[AppImage]] = []
        var currentPage = 0
        var numberOfPage = 0
        
        var selectedImage: AppImage?
        var title: String?
        
        var outputModel: OptionModel?
        
        var isSaveEnable: Bool {
            return title != nil && title != "" && selectedImage != nil
        }
    }
    
    enum CustomOptionTrigger {
        case optionTap(index: Int)
        case textChange(text: String)
        case goToPage(page: Int)
        case loadData
    }
}

