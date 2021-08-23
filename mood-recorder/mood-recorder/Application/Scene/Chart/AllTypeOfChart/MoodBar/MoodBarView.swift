//
//  MoodBarView.swift
//  MoodBarView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct MoodBarView: View {
    var datasource: [(emotion: CoreEmotion, percent: CGFloat)]

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

    init(datasource: [ChartData]) {
        let dict = Dictionary(grouping: datasource, by: { $0.emotion })
        let datas: [(emotion: CoreEmotion, percent: CGFloat)] = dict.map { (key, value) in
            return (key, CGFloat(value.count) / CGFloat(datasource.count))
        }
        
        var allEmotion: [(emotion: CoreEmotion, percent: CGFloat)] = CoreEmotion.allCases.map { ($0, 0) }
        
        for index in allEmotion.indices {
            guard let data = datas.first(where: {$0.emotion == allEmotion[index].emotion}) else {
                continue
            }
            allEmotion[index].percent = data.percent
        }
        
        self.datasource = allEmotion
    }
    
    private func precent(precent: CGFloat) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent

        return formatter.string(from: NSNumber(value: precent)) ?? "0%"
    }
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            
            VStack(spacing: 20) {
                if datasource.isEmpty || datasource.allSatisfy { $0.percent == 0 } {
                    Text("No diaries recorded")
                        .font(.system(size: 20))
                        .frame(height: 40)
                } else {
                    HStack(spacing: 0) {
                        ForEach(datasource.indices, id: \.self) { index in
                            let data = datasource[index]
                            data.emotion.color
                                .frame(width: width * data.percent, height: 40, alignment: .center)
                                .animation(.linear(duration: 1.0), value: width * data.percent)
                        }
                    }
                    .clipShape(Capsule())
                }
                
                HStack(spacing: 10) {
                    ForEach(datasource.indices, id: \.self) { index in
                        let data = datasource[index]
                        VStack {
                            data.emotion.image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)

                            Text(precent(precent: data.percent))
                                .animation(.linear, value: data.percent)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .animation(.linear, value: datasource.isEmpty || datasource.allSatisfy { $0.percent == 0 })
        .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
        .frame(height: 135)
    }
}

struct MoodBarView_Previews: PreviewProvider {
    static let mock = [ChartData(emotion: .neutral,
                                 index: 0),
                       ChartData(emotion: .happy,
                                 index: 5),
                       ChartData(emotion: .sad,
                                 index: 9),
                       ChartData(emotion: .blissful,
                                 index: 13),
                       ChartData(emotion: .sad,
                                 index: 15),
                       ChartData(emotion: .terrible,
                                 index: 20),
                       ChartData(emotion: .neutral,
                                 index: 28)]

    static var previews: some View {
        MoodBarView(datasource: mock)
    }
}
