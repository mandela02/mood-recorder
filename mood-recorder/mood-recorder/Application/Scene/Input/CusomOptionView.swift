//
//  CusomOptionView.swift
//  CusomOptionView
//
//  Created by LanNTH on 15/08/2021.
//

import SwiftUI

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
            state.outputModel = OptionModel(content: content)
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

struct CusomOptionView: View {
    typealias Function = () -> ()
    typealias CallbackFunction = (OptionModel) -> ()
    
    typealias CustomOptionState = CustomOptionViewModel.CustomOptionState
    typealias CustomOptionTrigger = CustomOptionViewModel.CustomOptionTrigger
    
    @ObservedObject var viewModel: BaseViewModel<CustomOptionState,
                                                 CustomOptionTrigger>
    
    @State private var currentIndex: Int = 0
    @State private var title: String = ""

    let namespace: Namespace.ID
    let onClose: Function
    let onCreate: CallbackFunction
    
    init(namespace: Namespace.ID,
         onClose: @escaping Function,
         onCreate: @escaping CallbackFunction) {
        self.namespace = namespace
        
        self.onClose = onClose
        self.onCreate = onCreate
        
        let customOptionState = CustomOptionState()
        viewModel = BaseViewModel(CustomOptionViewModel(state: customOptionState))
    }
    
    func iconBackgroundColor(_ isSelected: Bool) -> Color {
        return isSelected ? Theme.current.buttonColor.backgroundColor : Theme.current.buttonColor.disableColor
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
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Create your note")
                        .foregroundColor(Theme.current.commonColor.textColor)
                        .fontWeight(.bold)
                        .font(.system(size: 20))

                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Theme.current.commonColor.textColor)
                    }
                }
                .padding()
                
                TextField("Title", text: $title, prompt: Text("Enter your title"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: title) { newValue in
                        viewModel.trigger(.textChange(text: newValue))
                    }
                
                makePagingController()
                
                Text("\(viewModel.currentPage + 1)/\(viewModel.numberOfPage)")
                    .foregroundColor(Theme.current.commonColor.textColor)
                    .fontWeight(.regular)
                    .font(.system(size: 10))
            }
            
            Spacer()
            
            Button(action: {
                if viewModel.isSaveEnable {
                    viewModel.trigger(.loadData)
                    if let model = viewModel.outputModel {
                        onCreate(model)
                    }
                }
            }) {
                ZStack {
                    (viewModel.isSaveEnable ?
                     Theme.current.buttonColor.backgroundColor :
                        Theme.current.buttonColor.disableColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                    Image(systemName: "plus")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Theme.current.buttonColor.iconColor)
                }
            }
            .disabled(!viewModel.isSaveEnable)
            .animation(.easeInOut, value: viewModel.isSaveEnable)
            .matchedGeometryEffect(id: "SaveButton",
                                   in: namespace)
        }
        .background(Color.white)
        .cornerRadius(20)
    }
}
