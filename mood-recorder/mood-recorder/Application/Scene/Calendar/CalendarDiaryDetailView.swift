//
//  CalendarDiaryDetailView.swift
//  CalendarDiaryDetailView
//
//  Created by TriBQ on 8/21/21.
//

import SwiftUI

struct CalendarDiaryDetailView: View {
    var diary: InputDataModel
    
    @State private var imageModels: [ImageAndTitleModel] = []
    @State private var date: Date?
    @State private var emotion: CoreEmotion?
    
    init(diary: InputDataModel) {
        self.diary = diary
    }
    
    func generateData(diary: InputDataModel) {
        var contents: [ImageAndTitleModel] = []
        
        let array = diary.sections.map { $0.cell }
        for item in array {
            if let item = item as? [OptionModel] {
                let selected = item.filter { $0.isSelected }
                contents.append(contentsOf: selected.map { $0.content })
            }
        }
        
        imageModels = contents
        emotion = diary.emotion
        date = diary.date
    }
    
    func buildEmotionDate() -> some View {
        VStack {
            if let emotion = emotion {
                emotion.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            
            if let date = date {
                Text(date.dayMonthYearString)
                    .font(.system(size: 12))
                    .foregroundColor(Theme.current.buttonColor.textColor)
                    .padding(.all, 5)
                    .background(
                        Theme.current.buttonColor.backgroundColor
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
            }
            
            Spacer()
        }
    }
    
    func buildIconGrid(models: [ImageAndTitleModel]) -> some View {
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                                alignment: .top),
                                            count: 4),
                             content: {
                ForEach(models) { model in
                    Button(action: {
                    }, label: {
                        RoundImageView(image: Image(model.image.value),
                                       backgroundColor: Theme.current.buttonColor.disableColor)
                    })
                        .aspectRatio(1, contentMode: .fit)
                }
            })
            Spacer()
        }
    }
    
    var body: some View {
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 20))
            HStack(spacing: 20) {
                buildEmotionDate()
                buildIconGrid(models: imageModels)
                    .frame(maxWidth: .infinity)
            }.padding()
        }
        .padding()
        .onAppear {
            generateData(diary: self.diary)
        }
    }
}
