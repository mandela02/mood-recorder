//
//  CalendarDiaryDetailView.swift
//  CalendarDiaryDetailView
//
//  Created by TriBQ on 8/21/21.
//

import SwiftUI

struct CalendarDiaryDetailView: View {
    @State
    private var imageModels: [ImageAndTitleModel] = []
    
    @State
    private var date: Date?
   
    @State
    private var emotion: CoreEmotion?
    
    @State
    private var isTitleShow = false
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value

    var diary: DiaryDataModel
    let isButtonNeeded: Bool
    let onEditDiary: VoidFunction?
    let onDeleteDiary: VoidFunction?

    init(diary: DiaryDataModel,
         isButtonNeeded: Bool = true,
         onEditDiary: VoidFunction? = nil,
         onDeleteDiary: VoidFunction? = nil) {
        self.isButtonNeeded = isButtonNeeded
        self.diary = diary
        self.onEditDiary = onEditDiary
        self.onDeleteDiary = onDeleteDiary
    }
    
    func generateData(diary: DiaryDataModel) {
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
                    .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                    .padding(.all, 5)
                    .background(
                        Theme.get(id: themeId).buttonColor.backgroundColor
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
                    .onTapGesture {
                        onEditDiary?()
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
                                           backgroundColor: Theme.get(id: themeId).buttonColor.backgroundColor)
                                .blur(radius: isTitleShow ? 3 : 0)
                            
                            if isTitleShow {
                                Color.white
                                    .clipShape(Circle())
                                    .opacity(0.5)
                                Text(model.title)
                                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
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
                onEditDiary?()
            }, label: {
                Image(systemName: "pencil.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            })
            Button(action: {
                onDeleteDiary?()
            }, label: {
                Image(systemName: "trash.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            })
        }
        .padding(.horizontal, 20)
    }
    
    var body: some View {
        VStack {
            if isButtonNeeded {
                buildButton()
            }
            ZStack {
                Theme.get(id: themeId).commonColor.dialogBackground
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                HStack(spacing: 20) {
                    buildEmotionDate()
                                    
                    buildIconGrid(models: imageModels)
                        .frame(maxWidth: .infinity)
                }.padding()
            }
        }
        .frame(minHeight: 70)
        .onAppear {
            generateData(diary: self.diary)
        }
    }
}
