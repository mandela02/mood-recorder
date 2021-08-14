//
//  InputView.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI

struct InputView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: InputViewModel
    
    @FocusState private var isFocus: Bool
    
    init(emotion: CoreEmotion) {
        self.viewModel = InputViewModel(emotion: emotion)
        
        UITextView.appearance().backgroundColor =  UIColor(Theme.current.commonColor.textBackground)
        UITableView.appearance().backgroundColor = UIColor(Theme.current.tableViewColor.background)
    }
    
    // MARK: - Dismiss
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: - Icon background color
    func iconBackgroundColor(_ isSelected: Bool) -> Color {
        return isSelected ? Theme.current.buttonColor.backgroundColor : Theme.current.buttonColor.disableColor
    }
    
    // MARK: - Section Icon Type
    func getIconGrid(optionModels: [OptionModel], at sectionIndex: Int) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 5),
                  content: {
            ForEach(Array(optionModels.enumerated()),
                    id: \.offset) { optionIndex, optionModel in
                LazyVStack(spacing: 5) {
                    Button(action: {
                        isFocus = false
                        viewModel.onActionHappeded(action: .optionTap(sectionIndex: sectionIndex,
                                                                      optionIndex: optionIndex))
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
    
    // MARK: - Section Image Type
    func getImageContentCell(imageModel: ImageModel,
                             sectionIndex: Int) -> some View {
        Button(action: {
            isFocus = false
            viewModel.onActionHappeded(action: .imageButtonTapped)
        }) {
            ZStack {
                Theme.current.commonColor.textBackground
                if imageModel.isHavingData {
                    imageModel.image?
                        .resizable()
                        .renderingMode(.original)
                } else {
                    VStack {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Theme.current.tableViewColor.text)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text("Select a photo")
                            .foregroundColor(Theme.current.tableViewColor.text)
                    }
                }
                
            }
            .aspectRatio(imageModel.aspectRatio, contentMode: .fit)
            .cornerRadius(10)
        }
        .buttonStyle(ResizeAnimationButtonStyle())
        .sheet(isPresented: $viewModel.isImagePickerShowing) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.onActionHappeded(action: .pictureSelected(sectionIndex: sectionIndex,
                                                                    image: image))
            }
        }
    }
    
    // MARK: - Section Text Type
    var getTextView: some View {
        ZStack {
            Theme.current.commonColor.textBackground
            TextEditor(text: $viewModel.text)
                .foregroundColor(Theme.current.tableViewColor.text)
                .font(.system(size: 12))
                .padding()
                .focused($isFocus)
            Text(viewModel.text)
                .opacity(0)
                .font(.system(size: 12))
                .padding(.all, 8)
                .padding()
        }
        .cornerRadius(10)
        .frame(minHeight: 200)
    }
    
    // MARK: - Section Sleep Scheldule Type
    func getSleepScheduleText(model: SleepSchelduleModel) -> some View {
        ZStack {
            Theme.current.commonColor.textBackground
            Text(model.isHavingNilData ? "Select today sleep schedule" : model.hourString)
                .foregroundColor(Theme.current.tableViewColor.text)
                .font(.system(size: 12))
                .padding()
        }
        .cornerRadius(10)
        .frame(minHeight: 50)
    }
    
    // MARK: - Section Content
    @ViewBuilder
    func getSectionContent(at sectionModel: SectionModel, index: Int) -> some View {
        switch sectionModel.cell {
        case let models as [OptionModel]:
            VStack {
                getIconGrid(optionModels: models,
                            at: index)
                    .padding(.horizontal, 10)
                    .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                SizedBox(height: 10)
                if sectionModel.isEditable && sectionModel.isVisible && viewModel.isInEditMode {
                    Button(action: {}) {
                        ZStack {
                            Theme.current.buttonColor.backgroundColor
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Theme.current.buttonColor.iconColor)
                        }
                    }
                } else {
                    SizedBox(height: 0)
                }
            }
        case let model as ImageModel:
            getImageContentCell(imageModel: model,
                                sectionIndex: index)
                .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                .padding()
        case _ as TextModel:
            getTextView
                .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                .padding()
        case let model as SleepSchelduleModel:
            getSleepScheduleText(model: model)
                .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                .padding()
        default:
            Text("wait")
        }
    }
    
    // MARK: - Section dismiss button
    @ViewBuilder
    func sectionDismissButton(at sectionModel: SectionModel, onTap: @escaping () -> ()) -> some View {
        if viewModel.isInEditMode && sectionModel.isEditable {
            Button(action: onTap) {
                Image(systemName: sectionModel.isVisible ? "xmark.circle.fill" : "plus.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Theme.current.commonColor.textColor)
            }
            .buttonStyle(PlainButtonStyle())
        } else {
            EmptyView()
        }
    }
    
    // MARK: - Calculate section cell
    func getSectionCell(sectionModel: SectionModel, at index: Int) -> some View {
        Section(header: SizedBox(height: index == 0 ? 50 : 0)) {
            ZStack(alignment: .topLeading) {
                sectionModel.isVisible ? Theme.current.tableViewColor.cellBackground : Color.gray.opacity(0.5)
                VStack(alignment: .leading) {
                    HStack {
                        Text(sectionModel.title)
                            .foregroundColor(Theme.current.tableViewColor.text)
                        Spacer()
                        sectionDismissButton(at: sectionModel) {
                            viewModel.onActionHappeded(action: .onSectionVisibilityChanged(section: sectionModel.section))
                        }
                    }
                    .padding(.all, 10)
                    
                    getSectionContent(at: sectionModel, index: index)
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    // MARK: - Done Button
    var doneButton: some View {
        ZStack {
            Theme.current.buttonColor.backgroundColor
            Button(action: {
                viewModel.onActionHappeded(action: .doneButtonTapped)
                dismiss()
            }) {
                Text("Done")
                    .font(.system(size: 20))
                    .foregroundColor(Theme.current.buttonColor.textColor)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Navigation Bar
    var navigationBar: some View {
        HStack {
            Button(action: {
                isFocus = false
                viewModel.onActionHappeded(action: .editButtonTapped)
            }) {
                HStack {
                    Text( viewModel.isInEditMode ? "Done" : "Edit")
                        .foregroundColor(Theme.current.buttonColor.textColor)
                        .font(.system(size: 20))
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(Theme.current.buttonColor.textColor)
                }
            }
            Spacer()
            if !viewModel.isInEditMode {
                Button(action: {
                    isFocus = false
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(Theme.current.buttonColor.textColor)
                }
            }
        }
    }
    
    // MARK: - gradient
    func makeGradient() -> some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Theme.current.buttonColor.backgroundColor,
                                                           Color.clear]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .top)
                navigationBar
                    .padding(.horizontal, 20)
            }
            .frame(height: 80)
            Spacer()
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Theme.current.tableViewColor.background
            List {
                ForEach(Array(viewModel.visibles.enumerated()),
                        id: \.offset) { index, section in
                    getSectionCell(sectionModel: section,
                                   at: index)
                }
                
                Group() {
                    if viewModel.isInEditMode {
                        ForEach(Array(viewModel.hiddens.enumerated()),
                                id: \.offset) { index, section in
                            getSectionCell(sectionModel: section,
                                           at: index)
                        }
                    }
                }
                if !viewModel.isInEditMode {
                    Section(header: SizedBox(height: 0),
                            footer: SizedBox(height: isFocus ? 50 : 0)) {
                        doneButton
                    }
                }
            }
            makeGradient()
        }
        .onTapGesture {
            isFocus = false
        }
    }
}
