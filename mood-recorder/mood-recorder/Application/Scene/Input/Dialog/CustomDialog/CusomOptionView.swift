//
//  CusomOptionView.swift
//  CusomOptionView
//
//  Created by LanNTH on 15/08/2021.
//

import SwiftUI

struct CusomOptionView: View {
    typealias CustomOptionState = CustomOptionViewModel.CustomOptionState
    typealias CustomOptionTrigger = CustomOptionViewModel.CustomOptionTrigger
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

    @ObservedObject
    var viewModel: BaseViewModel<CustomOptionState,
                                 CustomOptionTrigger>
    
    @State
    private var currentIndex: Int = 0
    
    @State
    private var title: String = ""

    let namespace: Namespace.ID
    
    let onClose: VoidFunction
    let onCreate: OptionModelCallbackFunction
    let onUpdate: OptionModelCallbackFunction

    init(namespace: Namespace.ID,
         optionModel: OptionModel?,
         onClose: @escaping VoidFunction,
         onCreate: @escaping OptionModelCallbackFunction,
         onUpdate: @escaping OptionModelCallbackFunction) {
        
        self.namespace = namespace
        
        self.onClose = onClose
        self.onCreate = onCreate
        self.onUpdate = onUpdate
        
        let customOptionState = CustomOptionState(initialOptionModel: optionModel)
        viewModel = BaseViewModel(CustomOptionViewModel(state: customOptionState))
    }
    
    func iconBackgroundColor(_ isSelected: Bool) -> Color {
        return isSelected ? Theme.get(id: themeId).buttonColor.backgroundColor : Theme.get(id: themeId).buttonColor.disableColor
    }
    
    
    func getIconGrid(images: [AppImage]) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 5),
                  content: {
            ForEach(Array(images.enumerated()),
                    id: \.offset) { index, image in
                LazyVStack(spacing: 5) {
                    Button(action: {
                        viewModel.trigger(.optionTap(index: index))
                    }, label: {
                        RoundImageView(image: image.value.image,
                                       backgroundColor: iconBackgroundColor(image == viewModel.state.selectedImage))
                    })
                        .aspectRatio(1, contentMode: .fit)
                        .buttonStyle(ResizeAnimationButtonStyle())
                        .animation(Animation.easeInOut, value: image == viewModel.state.selectedImage)
                }
            }
        })
    }
    
    func makePagingController() -> some View {
        TabView(selection: $currentIndex) {
            ForEach(viewModel.images.indices, id: \.self) { index in
                VStack {
                    getIconGrid(images: viewModel.images[index])
                    Spacer()
                }
                .padding(.all, 5)
                .tag(index)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onChange(of: currentIndex) { newValue in
            viewModel.trigger(.goToPage(page: newValue))
        }
    }
    
    func makePlusButton() -> some View {
        Button(action: {
            if viewModel.isSaveEnable {
                viewModel.trigger(.loadData)
                if let model = viewModel.outputModel {
                    if viewModel.isInEditMode {
                        onUpdate(model)
                    } else {
                        onCreate(model)
                    }
                }
            }
        }) {
            ZStack {
                (viewModel.isSaveEnable ?
                 Theme.get(id: themeId).buttonColor.backgroundColor :
                    Theme.get(id: themeId).buttonColor.disableColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(Theme.get(id: themeId).buttonColor.iconColor)
            }
        }
        .disabled(!viewModel.isSaveEnable)
        .animation(.easeInOut, value: viewModel.isSaveEnable)
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Create your note")
                        .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                        .fontWeight(.bold)
                        .font(.system(size: 20))

                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                    }
                }
                .padding()
                
                TextField("Title", text: $title, prompt: Text("Enter your title"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: title) { newValue in
                        viewModel.trigger(.textChange(text: newValue))
                    }
                    .onAppear {
                        title = viewModel.state.title ?? ""
                    }
                
                makePagingController()
                
                Text("\(viewModel.currentPage + 1)/\(viewModel.numberOfPage)")
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                    .fontWeight(.regular)
                    .font(.system(size: 10))
                    .padding(.bottom, 5)
            }
            
            Spacer()
            
            if viewModel.isInEditMode {
                makePlusButton()
            } else {
                makePlusButton()
                    .matchedGeometryEffect(id: "SaveButton",
                                           in: namespace)
            }
        }
        .background(Theme.get(id: themeId).commonColor.dialogBackground)
        .cornerRadius(20)
    }
}
