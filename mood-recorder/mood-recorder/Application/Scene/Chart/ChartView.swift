//
//  ChartView.swift
//  ChartView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

struct ChartView: View {
    @ObservedObject
    var viewModel: BaseViewModel<ChartState,
                                 ChartTrigger>
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

    init(viewModel: BaseViewModel<ChartState, ChartTrigger>) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Theme.get(id: themeId).commonColor.viewBackground
                .ignoresSafeArea()
            VStack {
                LineChartView(month: viewModel.state.currentMonth.month,
                              year: viewModel.state.currentMonth.year,
                              datasource: viewModel.state.chartDatas)
            }
        }
    }
}
