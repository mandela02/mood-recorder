//
//  MoodBarView.swift
//  MoodBarView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct EmotionPercentChartView: View {
    enum ChartType {
        case bar
        case pie
    }
    
    var datasource: [ChartData]

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @State
    var type = ChartType.pie

    init(datasource: [ChartData]) {
        self.datasource = datasource
    }
        
    var body: some View {
        buildChart()
            .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            .frame(height: type == .bar ? 135 : 500)
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
        EmotionPercentChartView(datasource: mock)
    }
}
