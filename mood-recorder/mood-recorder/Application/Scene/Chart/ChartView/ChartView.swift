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

    @Binding
    var isTabBarHiddenNeeded: Bool
    
    init(viewModel: BaseViewModel<ChartState, ChartTrigger>,
         isTabBarHiddenNeeded: Binding<Bool>) {
        self.viewModel = viewModel
        self._isTabBarHiddenNeeded = isTabBarHiddenNeeded
    }

    private func showTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isTabBarHiddenNeeded = false
        }
    }

    var body: some View {
        ZStack {
            Theme.get(id: themeId).commonColor.viewBackground
                .ignoresSafeArea()
            VStack {
                buildDateNavigationView()
                ScrollView {
                    VStack {
                        SizedBox(height: 20)
                        buildLineChartView()
                        SizedBox(height: 150)
                        Spacer()
                    }
                }
            }
        }
        .overlay {
            if viewModel.state.isDatePickerShowing {
                buildMonthPicker()
            }
        }
    }
}

extension ChartView {
    private func buildLineChartView() -> some View {
        VStack(spacing: 15) {
            Text("Mood flow")
                .font(.system(size: 15))
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            LineChartView(month: viewModel.state.currentMonth.month,
                          year: viewModel.state.currentMonth.year,
                          datasource: viewModel.state.chartDatas,
                          precent: viewModel.chartShowPercent)
                .onAppear(perform: {
                    viewModel.trigger(.handleChartViewStatus(status: .open))
                })
                .onDisappear(perform: {
                    viewModel.trigger(.handleChartViewStatus(status: .close))
                })
            buildMoodBarView()
        }
        .padding()
    }
}

extension ChartView {
    private func buildMoodBarView() -> some View {
        EmotionPrecentChartCellView(chartDatas: viewModel.state.chartDatas)
    }
}

extension ChartView {
    private func buildMonthPicker() -> some View {
        MonthPicker(
            month: viewModel.currentMonth.month,
            year: viewModel.currentMonth.year,
            onApply: { (month, year) in
                viewModel.trigger(.handleChartViewStatus(status: .close))
                viewModel.trigger(.handleDatePickerViewStatus(status: .close))
                viewModel.trigger(.goTo(month: month, year: year))
                viewModel.trigger(.reload)
                viewModel.trigger(.handleChartViewStatus(status: .open))
                showTabBar()
            },
            onCancel: {
                viewModel.trigger(.handleDatePickerViewStatus(status: .close))
                showTabBar()
            })
    }
    
    private func buildDateNavigationView() -> some View {
        DateNavigationView(month: viewModel.state.currentMonth.month,
                           year: viewModel.state.currentMonth.year,
                           goToNextMonth: {
            viewModel.trigger(.handleChartViewStatus(status: .close))
            viewModel.trigger(.goToNextMonth)
            viewModel.trigger(.reload)
            viewModel.trigger(.handleChartViewStatus(status: .open))
        },
                           goToLastMonth: {
            viewModel.trigger(.handleChartViewStatus(status: .close))
            viewModel.trigger(.goToLastMonth)
            viewModel.trigger(.reload)
            viewModel.trigger(.handleChartViewStatus(status: .open))
        }, onDateTap: {
            isTabBarHiddenNeeded = true
            viewModel.trigger(.handleDatePickerViewStatus(status: .open))
        })
    }
}
