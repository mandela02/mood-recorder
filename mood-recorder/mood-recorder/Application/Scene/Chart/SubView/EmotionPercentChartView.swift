//
//  MoodBarView.swift
//  MoodBarView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct EmotionPercentChartView: View {    
    var datasource: [ChartData]

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    var type: ChartType

    init(datasource: [ChartData], chartType: ChartType) {
        self.datasource = datasource
        self.type = chartType
    }
        
    var body: some View {
        ZStack {
            if datasource.isEmpty {
                Text("No diaries recorded")
                    .font(.system(size: 20))
                    .frame(height: 40)
            } else {
                buildChart()
            }
        }
        .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
        .frame(height: datasource.isEmpty || type == .bar ? 135 : 470)
    }
}

extension EmotionPercentChartView {
    @ViewBuilder
    func buildChart() -> some View {
        switch type {
        case .pie:
            PieChartView(datasource: datasource)
        case .bar:
            MoodBarView(datasource: datasource)
        }
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
        EmotionPercentChartView(datasource: mock, chartType: .pie)
    }
}
