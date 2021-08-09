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
    
    init(emotion: CoreEmotion) {
        self.viewModel = InputViewModel(emotion: emotion)
        
        UITextView.appearance().backgroundColor =  UIColor(Theme.current.commonColor.textBackground)

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
    func getIconGrid(optionModels: [OptionModel], sectionModel: SectionModel) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 5),
                  content: {
                    ForEach(optionModels) { optionModel in
                        LazyVStack(spacing: 5) {
                            Button(action: {
                                viewModel.onActionHappeded(action: .optionTap(sectionModel: sectionModel, optionModel: optionModel))
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
    func getImagePicker(imageModel: ImageModel, sectionModel: SectionModel) -> some View {
        Button(action: {
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
                viewModel.onActionHappeded(action: .pictureSelected(sectionModel: sectionModel, image: image))
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
    func getSectionContent(at sectionModel: SectionModel) -> some View {
        switch sectionModel.cell {
        case let models as [OptionModel]:
            VStack {
                getIconGrid(optionModels: models, sectionModel: sectionModel)
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
            getImagePicker(imageModel: model, sectionModel: sectionModel)
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
        } else {
            EmptyView()
        }
    }
    
    // MARK: - Calculate section cell
    func getSectionCell(sectionModel: SectionModel) -> some View {
        ZStack(alignment: .topLeading) {
            Theme.current.tableViewColor.cellBackground
            VStack(alignment: .leading) {
                HStack {
                    Text(sectionModel.title)
                        .foregroundColor(Theme.current.tableViewColor.text)
                    Spacer()
                    sectionDismissButton(at: sectionModel) {
                        viewModel.onActionHappeded(action: .onSectionStatusChanged(sectionModel: sectionModel))
                    }
                }
                .padding(.all, 10)

                getSectionContent(at: sectionModel)
            }
        }
        .cornerRadius(10)
        .padding(.all, 10)
    }
    
    // MARK: - Done Button
    var doneButton: some View {
        Button(action: {
            viewModel.onActionHappeded(action: .doneButtonTapped)
            dismiss()
        }) {
            Text("Done")
                .font(.system(size: 20))
                .foregroundColor(Theme.current.buttonColor.textColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.current.buttonColor.backgroundColor
                                .ignoresSafeArea(.all, edges: .bottom))
        }
    }
    
    // MARK: - Navigation Bar
    var navigationBar: some View {
        HStack {
            Button(action: {
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
                    viewModel.onActionHappeded(action: .closeButtonTapped)
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
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Theme.current.tableViewColor.background.ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    SizedBox(height: 80)
                    
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.inputDataModel.sections) { section in
                            if viewModel.isInEditMode {
                                ZStack {
                                    section.isVisible ? Color.clear : Color.gray
                                    getSectionCell(sectionModel: section)
                                }
                            } else if section.isVisible {
                                getSectionCell(sectionModel: section)
                            } else {
                                SizedBox(height: 0)
                            }
                        }
                    }
                    
                    SizedBox(height: 10)
                }
                if !viewModel.isInEditMode {
                    doneButton
                }
            }
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
        .onTapGesture {
            viewModel.onActionHappeded(action: .dismissKeyboard)
        }
    }
}
