//
//  OptionAdditionView.swift
//  OptionAdditionView
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

class OptionAdditionViewModel: ViewModel {
    @Published var state: OptionAdditionState
    
    init(state: OptionAdditionState) {
        self.state = state
        
        var allModel = state.initialSectionModel
            .section
            .allOptions
            .enumerated()
            .map { OptionModel(content: $1,
                               optionID: $0,
                               isSelected: false) }
        
        guard let currentSelectedOptions = state.initialSectionModel.cell as? [OptionModel] else { return }
        for index in allModel.indices {
            let model = allModel[index]
            if currentSelectedOptions.contains(where: {$0.content == model.content}) {
                allModel[index].changeSelectionStatus()
            }
        }
        
        self.state.optionModels = allModel.chunked(into: 15)
        self.state.numberOfPage = self.state.optionModels.count
        self.state.displayOption = self.state.optionModels[state.currentPage]
    }
    
    func trigger(_ input: OptionAdditionTrigger) {
        switch input {
        case .optionTap(let optionIndex):
            state.optionModels[state.currentPage][optionIndex]
                .changeSelectionStatus()
        case .goToPage(let page):
            state.currentPage = page
        case .loadData:
            self.state.displayOption = state.optionModels[state.currentPage]
        }
    }
    
    struct OptionAdditionState {
        var initialSectionModel: SectionModel
        var optionModels: [[OptionModel]] = []
        var currentPage = 0
        var numberOfPage = 0
        var displayOption: [OptionModel] = []
    }
    
    enum OptionAdditionTrigger {
        case optionTap(optionIndex: Int)
        case goToPage(page: Int)
        case loadData
    }
}

struct OptionAdditionView: View {
    typealias Function = () -> ()
    typealias OptionAdditionState = OptionAdditionViewModel.OptionAdditionState
    typealias OptionAdditionTrigger = OptionAdditionViewModel.OptionAdditionTrigger

    @ObservedObject var viewModel: BaseViewModel<OptionAdditionState,
                                                 OptionAdditionTrigger>

    let onConfirm: Function
    let onCancel: Function
    
    @State var currentIndex: Int = 0
    
    init(sectionModel: SectionModel,
         onConfirm: @escaping Function,
         onCancel: @escaping Function) {
        let optionAdditionState = OptionAdditionState(initialSectionModel: sectionModel)
        viewModel = BaseViewModel(OptionAdditionViewModel(state: optionAdditionState))

        self.onCancel = onCancel
        self.onConfirm = onConfirm
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Theme.current.buttonColor.backgroundColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Theme.current.buttonColor.disableColor)
    }
    
    func iconBackgroundColor(_ isSelected: Bool) -> Color {
        return isSelected ? Theme.current.buttonColor.backgroundColor : Theme.current.buttonColor.disableColor
    }
    
    func getIconGrid(optionModels: [OptionModel]) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 5),
                  content: {
            ForEach(Array(optionModels.enumerated()),
                    id: \.offset) { optionIndex, optionModel in
                LazyVStack(spacing: 5) {
                    Button(action: {
                        viewModel.trigger(.optionTap(optionIndex: optionIndex))
                    }, label: {
                        RoundImageView(image: optionModel.content.image.image,
                                       backgroundColor: iconBackgroundColor(optionModel.isSelected))
                    })
                        .aspectRatio(1, contentMode: .fit)
                        .saturation(optionModel.isSelected ? 1 : 0)
                        .buttonStyle(ResizeAnimationButtonStyle())
                    
                    if optionModel.content.title != "" {
                        Text(optionModel.content.title)
                            .foregroundColor(Theme.current.tableViewColor.text)
                            .font(.system(size: 12))
                    }
                }
            }
        })
    }
    
    func makePagingController() -> some View {
        TabView(selection: $currentIndex) {
            ForEach(viewModel.optionModels.indices, id: \.self) { index in
                VStack {
                    getIconGrid(optionModels: viewModel.optionModels[index])
                    Spacer()
                }
                .tag(index)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onChange(of: currentIndex) { newValue in
            viewModel.trigger(.goToPage(page: newValue))
        }
    }
    
    func createButton(title: String,
                      background: Color = Theme.current.buttonColor.backgroundColor,
                      callback: @escaping Function) -> some View {
        Button(action: callback) {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Theme.current.buttonColor.textColor)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .background(background)
        .cornerRadius(20)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Add more option to your collection")
                    .foregroundColor(Theme.current.commonColor.textColor)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding(.all, 10)
                Spacer()
            }
            
            makePagingController()
                .padding(.horizontal, 10)
            
            SizedBox(height: 10)
            
            VStack {
                createButton(title: "Confirm", callback: onConfirm)
                createButton(title: "Cancel", callback: onCancel)
            }
            .padding(.horizontal, 30)
        }
    }
}
