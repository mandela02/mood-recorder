//
//  HomeScene.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

struct HomeView: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value
    
    @State
    var isTabBarHiddenNeeded = false
    
    @ObservedObject
    var viewModel: BaseViewModel<HomeState, HomeTrigger>
    
    init(viewModel: BaseViewModel<HomeState, HomeTrigger>) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    var tintForeGroundColor: some View {
        Group {
            if viewModel.isEmotionDialogShowing {
                Color.black.opacity(0.5)
            } else {
                Color.clear
            }
        }.onTapGesture(perform: {
            viewModel.trigger(.handleEmotionDialog(status: .close))
        })
    }
    
    @ViewBuilder
    var tabView: some View {
        switch viewModel.state.seletedTabBarView {
        case .calendar:
            CalendarView(viewModel: viewModel.calendarViewModel,
                         isTabBarHiddenNeeded: $isTabBarHiddenNeeded,
                         onDiarySelected: { model in
                guard let model = model else {
                    return
                }
                viewModel.trigger(.selectDiary(model: model))
                viewModel.trigger(.handleDiaryView(status: .open))
            })
        case .timeline:
            TimelineView(viewModel: viewModel.timelineViewModel,
                         isTabBarHiddenNeeded: $isTabBarHiddenNeeded, onDiarySelected: { model in
                guard let model = model else {
                    return
                }
                viewModel.trigger(.selectDiary(model: model))
                viewModel.trigger(.handleDiaryView(status: .open))
            })
        case .chart:
            ChartView(viewModel: viewModel.chartViewModel,
                      isTabBarHiddenNeeded: $isTabBarHiddenNeeded)
        case .setting:
            SettingView(isTabBarHiddenNeeded: $isTabBarHiddenNeeded)
        }
    }
    
    @ViewBuilder
    var emotionListDialog: some View {
        if viewModel.isEmotionDialogShowing {
            TalkBubble(backgroundColor: Theme.get(id: themeId).commonColor.dialogBackground,
                       buttonBackgroundColor: Theme.get(id: themeId).buttonColor.disableColor,
                       textColor: Theme.get(id: themeId).commonColor.textColor,
                       onButtonTap: {
                viewModel.trigger(.handleEmotionDialog(status: .close))
                viewModel.trigger(.selectEmotion(emotion: $0))
                viewModel.trigger(.handleDiaryView(status: .open))
            })
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabView
            tintForeGroundColor
                .ignoresSafeArea()
            if !isTabBarHiddenNeeded {
                VStack(spacing: 20) {
                    emotionListDialog
                    CustomTabBar(
                        selectedIndex: viewModel.state.seletedTabBarView.rawValue,
                        backgroundColor: .white,
                        selectedItemColor: Theme.get(id: themeId).buttonColor.backgroundColor,
                        unselectedItemColor: .gray,
                        onBigButtonTapped: {
                            viewModel.trigger(.handleEmotionDialog(status: .open))
                        }, onTabSelect: {
                            viewModel.trigger(.handleTab(index: $0))
                        })
                        .animation(.linear, value: viewModel.state.seletedTabBarView)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .overlay {
            if viewModel.state.isDiaryShow,
                let diaryViewModel = viewModel.state.diaryViewModel {
                DiaryView(viewModel: diaryViewModel,
                          onClose: {
                    viewModel.trigger(.handleDiaryView(status: .close))
                    viewModel.trigger(.clear)
                })
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut, value: viewModel.state.seletedTabBarView)
        .animation(.easeInOut, value: viewModel.state.isDiaryShow)
        .animation(.easeInOut, value: isTabBarHiddenNeeded)
        .animation(Animation.easeInOut.speed(1.5), value: viewModel.state.isEmotionDialogShowing)
    }
}
