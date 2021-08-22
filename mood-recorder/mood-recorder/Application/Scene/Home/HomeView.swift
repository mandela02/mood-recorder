//
//  HomeScene.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

struct HomeView: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @AppStorage(Keys.isUsingSystemTheme.rawValue)
    var isUsingSystemTheme: Bool = false

    @Environment(\.colorScheme)
    var colorScheme
    
    @ObservedObject
    var viewModel = HomeViewModel()
    
    @ViewBuilder
    var tintForeGroundColor: some View {
        Group {
            if viewModel.isEmotionDialogShowing {
                Color.black.opacity(0.5)
            } else {
                Color.clear
            }
        }.onTapGesture(perform: viewModel.onBigButtonTapped)
    }
    
    var tabView: some View {
        TabView(selection: $viewModel.seletedTabBarIndex,
                content: {
            CalendarView(viewModel: viewModel.calendarViewModel,
                         isTabBarHiddenNeeded: $viewModel.isTabBarHiddenNeeded)
                .tag(0)
            Color.green.tag(1)
                .ignoresSafeArea()
            ChartView(viewModel: viewModel.chartViewModel,
                      isTabBarHiddenNeeded: $viewModel.isTabBarHiddenNeeded)
                .tag(2)
            SettingView(isTabBarHiddenNeeded: $viewModel.isTabBarHiddenNeeded)
                .tag(3)
        })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    @ViewBuilder
    var emotionListDialog: some View {
        if viewModel.isEmotionDialogShowing {
            TalkBubble(backgroundColor: Theme.get(id: themeId).commonColor.dialogBackground,
                       buttonBackgroundColor: Theme.get(id: themeId).buttonColor.disableColor,
                       textColor: Theme.get(id: themeId).commonColor.textColor,
                       onButtonTap: viewModel.onEmotionSelected)
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabView
                .ignoresSafeArea()
            tintForeGroundColor
                .ignoresSafeArea()
            if !viewModel.isTabBarHiddenNeeded {
                VStack(spacing: 20) {
                    emotionListDialog
                    CustomTabBar(
                        selectedIndex: $viewModel.seletedTabBarIndex,
                        backgroundColor: .white,
                        selectedItemColor: Theme.get(id: themeId).buttonColor.backgroundColor,
                        unselectedItemColor: .gray,
                        onBigButtonTapped: viewModel.onBigButtonTapped)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut, value: viewModel.isTabBarHiddenNeeded)
        .animation(Animation.easeInOut.speed(1.5), value: viewModel.isEmotionDialogShowing)
        .fullScreenCover(isPresented: $viewModel.isInputViewShow,
                         onDismiss: viewModel.onInputViewDismiss, content: {
            if let selectedCoreEmotion = viewModel.selectedCoreEmotion {
                InputView(emotion: selectedCoreEmotion)
            } else {
                Color.clear
            }
        })
        .preferredColorScheme(isUsingSystemTheme ? nil : Theme.get(id: themeId).colorScheme)
        .onAppear(perform: {
            if isUsingSystemTheme {
                Theme.post(themeId: colorScheme == .dark ? 1 : 0)
            }
        })
        .onChange(of: colorScheme, perform: { newValue in
            if isUsingSystemTheme {
                Theme.post(themeId: newValue == .dark ? 1 : 0)
            }
        })
    }
}
