//
//  MoodBarCellView.swift
//  MoodBarCellView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct MoodBarView: View {
    var datasource: [PercentChartData]

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value

    init(datasource: [ChartData]) {
        let dict = Dictionary(grouping: datasource, by: { $0.emotion })
        let datas: [PercentChartData] = dict.map { (key, value) in
            return PercentChartData(emotion: key,
                                    percent: CGFloat(value.count) / CGFloat(datasource.count))
        }
        
        var allEmotion: [PercentChartData] = CoreEmotion.allCases.map { PercentChartData(emotion: $0,
                                                                                         percent: 0) }
        
        for index in allEmotion.indices {
            guard let data = datas.first(where: {$0.emotion == allEmotion[index].emotion}) else {
                continue
            }
            allEmotion[index].percent = data.percent
        }
        
        self.datasource = allEmotion
    }

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width

            VStack(spacing: 20) {
                HStack(spacing: 0) {
                    ForEach(datasource.indices, id: \.self) { index in
                        let data = datasource[index]
                        data.emotion.color
                            .frame(width: width * data.percent, height: 40, alignment: .center)
                            .animation(.linear(duration: 1.0), value: width * data.percent)
                    }
                }
                .clipShape(Capsule())

                HStack(spacing: 10) {
                    ForEach(datasource.indices, id: \.self) { index in
                        let data = datasource[index]
                        VStack {
                            data.emotion.image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)

                            Text(ChartHelper.precent(precent: data.percent))
                                .animation(.linear, value: data.percent)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .animation(.linear, value: datasource.isEmpty || datasource.allSatisfy { $0.percent == 0 })
    }
}
