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
    
    @State private var isTitleShow = false
    
    let onEditDiary: VoidFunction
    let onDeleteDiary: VoidFunction

    init(diary: InputDataModel,
         onEditDiary: @escaping VoidFunction,
         onDeleteDiary: @escaping VoidFunction) {
        self.diary = diary
        self.onEditDiary = onEditDiary
        self.onDeleteDiary = onDeleteDiary
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
                    .onTapGesture {
                        onEditDiary()
                    }
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
                        isTitleShow.toggle()
                    }, label: {
                        ZStack {
                            RoundImageView(image: Image(model.image.value),
                                           backgroundColor: Theme.current.buttonColor.disableColor)
                                .blur(radius: isTitleShow ? 3 : 0)
                            
                            if isTitleShow {
                                Color.white
                                    .clipShape(Circle())
                                    .opacity(0.5)
                                Text(model.title)
                                    .foregroundColor(Theme.current.commonColor.textColor)
                                    .font(.system(size: 8))
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.1)
                            }
                        }
                    })
                        .aspectRatio(1, contentMode: .fit)
                }
            })
                .animation(.easeInOut, value: isTitleShow)
            Spacer()
        }
    }
    
    func buildButton() -> some View {
        HStack(spacing: 20) {
            Spacer()
            Button(action: {
                onEditDiary()
            }) {
                Image(systemName: "pencil.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Theme.current.commonColor.textColor)
            }
            Button(action: {
                onDeleteDiary()
            }) {
                Image(systemName: "trash.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Theme.current.commonColor.textColor)
            }
        }
        .padding(.horizontal, 20)
    }
    
    var body: some View {
        VStack {
            buildButton()
            ZStack {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                HStack(spacing: 20) {
                    buildEmotionDate()
                                    
                    buildIconGrid(models: imageModels)
                        .frame(maxWidth: .infinity)
                }.padding()
            }
        }
        .padding()
        .onAppear {
            generateData(diary: self.diary)
        }
    }
}
