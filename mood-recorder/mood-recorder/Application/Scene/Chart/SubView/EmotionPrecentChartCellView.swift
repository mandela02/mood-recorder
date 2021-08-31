//
//  EmotionPrecentChartCellView.swift
//  EmotionPrecentChartCellView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct EmotionPrecentChartCellView: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value
    
    @State
    var type = ChartType.pie
    
    let chartDatas: [ChartData]

    var body: some View {
        ZStack {
            Theme.get(id: themeId).tableViewColor.cellBackground
                .cornerRadius(20)
            VStack {
                Text("Mood Bar")
                    .font(.system(size: 15))
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                Picker("", selection: $type) {
                    ForEach(ChartType.allCases, id: \.self) {
                        Text($0.value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                SizedBox(height: 20)
                EmotionPercentChartView(datasource: chartDatas, chartType: type)
                    .padding(.all, 5)
                    .frame(maxWidth: .infinity)
                    .animation(.linear, value: type)
            }
            .padding()
        }
    }
}
