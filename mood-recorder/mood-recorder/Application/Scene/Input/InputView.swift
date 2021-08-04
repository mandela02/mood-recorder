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
                            
                            Text(model.content.title)
                                .font(.system(size: 12))
                        }
                    }
                  })
    }
    
    func getImagePicker(model: ImageModel, section: SectionModel) -> some View {
        Button(action: viewModel.showImagePicker) {
            ZStack {
                Color.green
                model.image
                    .resizable()
                    .renderingMode(.original)
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
    
    @ViewBuilder
    func getContentCell(section: SectionModel) -> some View {
        switch section.cell {
        case let models as [OptionModel]:
            getIconGrid(models: models, section: section)
        case let model as ImageModel:
            getImagePicker(model: model, section: section)
        default:
            Text("wait")
        }
    }
    
    func getSectionCell(section: SectionModel) -> some View {
        ZStack(alignment: .topLeading) {
            Color.white
            VStack(alignment: .leading) {
                Text(section.title)
                getContentCell(section: section)
            }
            .padding()
        }
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.inputDataModel.visibleSections) { section in
                        getSectionCell(section: section)
                    }
                }
            }
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
