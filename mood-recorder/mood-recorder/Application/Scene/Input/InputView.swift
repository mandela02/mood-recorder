//
//  InputView.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI


struct InputView: View {
    @ObservedObject var viewModel = InputViewModel()
    
    init() {
        UITextView.appearance().backgroundColor =  UIColor(Theme.current.commonColor.textBackground)

    }
    
    func iconBackgroundColor(_ isSelected: Bool) -> Color {
        return isSelected ? Theme.current.buttonColor.backgroundColor : Theme.current.buttonColor.disableColor
    }
        
    func getIconGrid(models: [OptionModel], section: SectionModel) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 5),
                  content: {
                    ForEach(models) { model in
                        LazyVStack(spacing: 5) {
                            Button(action: {
                                viewModel.onOptionTap(sectionModel: section, optionModel: model)
                            }, label: {
                                RoundImageView(image: model.content.image.image,
                                               backgroundColor: iconBackgroundColor(model.isSelected))
                            })
                            .aspectRatio(1, contentMode: .fit)
                            .saturation(model.isSelected ? 1 : 0)
                            .buttonStyle(ResizeAnimationButtonStyle())
                            
                            if model.content.title != "" {
                                Text(model.content.title)
                                    .foregroundColor(Theme.current.tableViewColor.text)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                  })
    }
    
    func getImagePicker(model: ImageModel, section: SectionModel) -> some View {
        Button(action: viewModel.showImagePicker) {
            ZStack {
                Theme.current.commonColor.textBackground
                if model.isHavingData {
                    model.image?
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
            .aspectRatio(model.aspectRatio, contentMode: .fit)
            .cornerRadius(10)
        }
        .buttonStyle(ResizeAnimationButtonStyle())
        .sheet(isPresented: $viewModel.isImagePickerShowing) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.onPictureSelected(sectionModel: section, image: image)
            }
        }
    }
    
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
    
    @ViewBuilder
    func getContentCell(section: SectionModel) -> some View {
        switch section.cell {
        case let models as [OptionModel]:
            VStack {
                getIconGrid(models: models, section: section)
                    .padding(.horizontal, 10)
                    .disabled(!section.isVisible || viewModel.isInEditMode)
                SizedBox(height: 10)
                if section.isEditable && section.isVisible && viewModel.isInEditMode {
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
                }
            }
        case let model as ImageModel:
            getImagePicker(model: model, section: section)
                .disabled(!section.isVisible || viewModel.isInEditMode)
                .padding()
        case _ as TextModel:
            getTextView
                .disabled(!section.isVisible || viewModel.isInEditMode)
                .padding()
        case let model as SleepSchelduleModel:
            getSleepScheduleText(model: model)
                .disabled(!section.isVisible || viewModel.isInEditMode)
                .padding()
        default:
            Text("wait")
        }
    }
    
    @ViewBuilder
    func sectionDismissButton(sectionModel: SectionModel, onTap: @escaping () -> ()) -> some View {
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
    
    func getSectionCell(section: SectionModel) -> some View {
        ZStack(alignment: .topLeading) {
            Theme.current.tableViewColor.cellBackground
            VStack(alignment: .leading) {
                HStack {
                    Text(section.title)
                        .foregroundColor(Theme.current.tableViewColor.text)
                    Spacer()
                    sectionDismissButton(sectionModel: section) {
                        viewModel.onSectionDismiss(sectionModel: section)
                    }
                }
                .padding(.all, 10)

                getContentCell(section: section)
            }
        }
        .cornerRadius(10)
        .padding(.all, 10)
    }
    
    var doneButton: some View {
        Button(action: {}) {
            Text("Done")
                .font(.system(size: 20))
                .foregroundColor(Theme.current.buttonColor.textColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.current.buttonColor.backgroundColor
                                .ignoresSafeArea(.all, edges: .bottom))
        }
    }
    
    var navigationBar: some View {
        HStack {
            if !viewModel.isInEditMode {
                Button(action: viewModel.onEditButtonTapped) {
                    HStack {
                        Text("Edit")
                            .foregroundColor(Theme.current.buttonColor.textColor)
                            .font(.system(size: 20))
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Theme.current.buttonColor.textColor)
                    }
                }
            }
            Spacer()
            Button(action: viewModel.onCloseButtonTapped) {
                Image(systemName: "xmark")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Theme.current.buttonColor.textColor)
            }
        }
    }
    
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
                                    getSectionCell(section: section)
                                }
                            } else if section.isVisible {
                                getSectionCell(section: section)
                            } else {
                                Color.clear
                                    .frame(height: 0)
                            }
                        }
                    }
                    
                    SizedBox(height: 10)
                }
                doneButton
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
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
