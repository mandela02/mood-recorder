//
//  InputView.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI


struct InputView: View {
    @ObservedObject var viewModel = InputViewModel()
    
    func getIconGrid(models: [OptionModel], section: SectionModel) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 5),
                  content: {
                    ForEach(models) { model in
                        VStack(spacing: 5) {
                            Button(action: {
                                viewModel.onOptionTap(section: section.section, optionModel: model)
                            }, label: {
                                RoundImageView(image: model.content.image.image,
                                               backgroundColor: model.isSelected ? .green : .gray)
                            })
                            .aspectRatio(1, contentMode: .fit)
                            .saturation(model.isSelected ? 1 : 0)
                            .buttonStyle(ResizeAnimationButtonStyle())
                            
                            if model.content.title != "" {
                                Text(model.content.title)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                  })
    }
    
    func getImagePicker(model: ImageModel, section: SectionModel) -> some View {
        Button(action: viewModel.showImagePicker) {
            ZStack {
                Color.green
                if model.isHavingData {
                    model.image?
                        .resizable()
                        .renderingMode(.original)
                } else {
                    VStack {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text("Select a photo")
                    }
                }
                
            }
            .aspectRatio(model.aspectRatio, contentMode: .fit)
            .cornerRadius(10)
        }
        .buttonStyle(ResizeAnimationButtonStyle())
        .sheet(isPresented: $viewModel.isImagePickerShowing) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.onPictureSelected(section: section.section, image: image)
            }
        }
    }
    
    func getTextView() -> some View {
        ZStack {
            TextEditor(text: $viewModel.text)
                .font(.system(size: 12))
            Text(viewModel.text)
                .opacity(0)
                .font(.system(size: 12))
                .padding(.all, 8)
        }
        .frame(minHeight: 200)
    }
    
    @ViewBuilder
    func getContentCell(section: SectionModel) -> some View {
        switch section.cell {
        case let models as [OptionModel]:
            VStack {
                getIconGrid(models: models, section: section)
                    .padding(.horizontal, 10)
                
                if viewModel.isInEditMode {
                    Button(action: {}) {
                        ZStack {
                            Color.green
                                .opacity(0.5)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.white)
                        }
                    }
                } else {
                    SizedBox(height: 10)
                }
            }
        case let model as ImageModel:
            getImagePicker(model: model, section: section)
                .padding()
        case _ as TextModel:
            getTextView()
                .padding()
        default:
            Text("wait")
        }
    }
    
    func getSectionCell(section: SectionModel) -> some View {
        ZStack(alignment: .topLeading) {
            Color.white
            VStack(alignment: .leading) {
                Text(section.title)
                    .padding(.all, 10)
                getContentCell(section: section)
            }
        }
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
    
    var doneButton: some View {
        Button(action: {}) {
            Text("Done")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red
                                .ignoresSafeArea(.all, edges: .bottom))
        }
    }
    
    var navigationBar: some View {
        HStack {
            if !viewModel.isInEditMode {
                Button(action: viewModel.onEditButtonTapped) {
                    HStack {
                        Text("Edit")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.white)
                    }
                }
            }
            Spacer()
            Button(action: viewModel.onCloseButtonTapped) {
                Image(systemName: "xmark")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.white)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                navigationBar
                    .padding()
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.inputDataModel.visibleSections) { section in
                        getSectionCell(section: section)
                    }
                }
                SizedBox(height: 60)
            }
            VStack {
                Spacer()
                doneButton
            }
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
