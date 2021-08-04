//
//  InputView.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI


struct InputView: View {
    @ObservedObject var viewModel = InputViewModel()
    
    @ViewBuilder
    func getContentCell(section: SectionModel) -> some View {
        if let models = section.cell as? [OptionModel] {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .top),
                                     count: 5),
                      content: {
                        ForEach(models) { model in
                            VStack(spacing: 0) {
                                Button(action: {
                                    viewModel.onOptionTap(section: section.section,
                                                          optionModel: model)
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
        } else {
            Text("wait")
        }
    }
    
    func getSectionCell(section: SectionModel) -> some View {
        return ZStack(alignment: .topLeading) {
            Color.white
            VStack(alignment: .leading) {
                Text(section.title)
                getContentCell(section: section)
            }
            .padding()
        }
        .cornerRadius(10)
        .padding()
    }
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            ScrollView(.vertical,
                       showsIndicators: false, content: {
                        LazyVStack {
                            ForEach(viewModel.inputDataModel.visibleSections) { section in
                                getSectionCell(section: section)
                            }
                        }
                       })
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
