//
//  OptionAdditionView.swift
//  OptionAdditionView
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

struct OptionAdditionView: View {
    typealias Function = () -> ()
    typealias CallbackFunction = ([OptionModel]) -> ()
    
    typealias OptionAdditionState = OptionAdditionViewModel.OptionAdditionState
    typealias OptionAdditionTrigger = OptionAdditionViewModel.OptionAdditionTrigger
    
    @ObservedObject var viewModel: BaseViewModel<OptionAdditionState,
                                                 OptionAdditionTrigger>
    
    let onConfirm: CallbackFunction
    let onCancel: Function
    
    @State var currentIndex: Int = 0
    @State var isAboutToAddMore: Bool = false

    @Namespace var namespace
    
    init(sectionModel: SectionModel,
         onConfirm: @escaping CallbackFunction,
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
    
    func plusButtonImage() -> some View {
        ZStack {
            Theme.current.buttonColor.backgroundColor
                .clipShape(Circle())
            Image(systemName: "plus")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .foregroundColor(Theme.current.buttonColor.iconColor)
                .clipShape(Circle())
        }
    }
    
    func getIconCell(optionIndex: Int, optionModel: OptionModel) -> some View {
        LazyVStack(spacing: 5) {
            Button(action: {
                if optionModel.content.image == .systemPlus {
                    viewModel.trigger(.clear)
                    isAboutToAddMore.toggle()
                } else {
                    viewModel.trigger(.optionTap(optionIndex: optionIndex))
                }
            }, label: {
                if optionModel.content.image == .systemPlus {
                    if !isAboutToAddMore {
                        plusButtonImage()
                            .matchedGeometryEffect(id: "SaveButton",
                                                   in: namespace)
                    } else {
                        Color.clear
                    }
                } else {
                    RoundImageView(image: optionModel.content.image.value.image,
                                   backgroundColor: iconBackgroundColor(optionModel.isSelected))
                        .saturation(optionModel.isSelected ? 1 : 0)
                }
            })
                .aspectRatio(1, contentMode: .fit)
                .buttonStyle(ResizeAnimationButtonStyle())
                .animation(Animation.easeInOut, value: optionModel.isSelected)
            
            if optionModel.content.title != "" {
                Text(optionModel.content.title)
                    .foregroundColor(Theme.current.tableViewColor.text)
                    .font(.system(size: 12))
            }
        }
    }
    
    @ViewBuilder
    func getIconGrid(optionModels: [OptionModel]) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 5),
                  content: {
            ForEach(optionModels.indices,
                    id: \.self) { optionIndex in
                let optionModel = optionModels[optionIndex]
                
                if viewModel.isCustomSection && optionModel.content.image != .systemPlus {
                    getIconCell(optionIndex: optionIndex, optionModel: optionModel)
                        .contextMenu {
                            Button {
                                viewModel.trigger(.editStart(model: optionModel))
                                isAboutToAddMore.toggle()
                            } label: {
                                Label("Edit", systemImage: "globe")
                            }
                            
                            Button {
                                viewModel.trigger(.delete(model: optionModel))
                            } label: {
                                Label("Delete", systemImage: "location.circle")
                            }
                        }
                } else {
                    getIconCell(optionIndex: optionIndex, optionModel: optionModel)
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
                .padding(.all, 5)
                .tag(index)
            }
        }
        .aspectRatio(0.95, contentMode: .fit)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onChange(of: currentIndex) { newValue in
            viewModel.trigger(.goToPage(page: newValue))
        }
        .onChange(of: viewModel.state.currentPage) { newValue in
            currentIndex = newValue
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
    
    var customSectionDialogContent: some View {
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
                createButton(title: "Confirm", callback: {
                    viewModel.trigger(.loadData)
                    onConfirm(viewModel.state.outPutModels)
                })
                createButton(title: "Cancel", callback: onCancel)
            }
            .padding(.horizontal, 30)
        }
    }
    
    var addMoreDialog: some View {
        CusomOptionView(namespace: namespace,
                        optionModel: viewModel.selectedModel,
                        onClose: {
            isAboutToAddMore.toggle()
            self.viewModel.trigger(.clear)
        }, onCreate: { model in
            isAboutToAddMore.toggle()
            self.viewModel.trigger(.addData(model: model))
        }, onUpdate: { model in
            isAboutToAddMore.toggle()
            self.viewModel.trigger(.editEnd(model: model))
        })
    }
    
    var body: some View {
        ZStack {
            customSectionDialogContent
                .padding()
        }
        .overlay {
            if isAboutToAddMore {
                addMoreDialog
            }
        }
        .animation(.easeInOut, value: isAboutToAddMore)
    }
}
