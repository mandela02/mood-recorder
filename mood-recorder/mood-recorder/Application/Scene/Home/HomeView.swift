//
//  HomeScene.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    init() {
        UITabBar.appearance().isHidden = true
    }

    var tintForeGroundColor: some View {
        (viewModel.isEmotionDialogShowing ? Color.black.opacity(0.5) : .clear)
            .onTapGesture(perform: viewModel.onBigButtonTapped)
    }
        
    var tabView: some View {
        TabView(selection: $viewModel.seletedTabBarIndex,
                content:  {
                    Color.red.tag(0)
                        .ignoresSafeArea()
                    Color.green.tag(1)
                        .ignoresSafeArea()
                    Color.blue.tag(2)
                        .ignoresSafeArea()
                    Color.yellow.tag(3)
                        .ignoresSafeArea()
                })
    }
    
    @ViewBuilder
    var emotionListDialog: some View {
        if viewModel.isEmotionDialogShowing {
            TalkBubble(backgroundColor: .white,
                       buttonBackgroundColor: Theme.current.buttonColor.disableColor,
                       textColor: Theme.current.commonColor.textColor,
                       onButtonTap: viewModel.onEmotionSelected)
                .transition(.asymmetric(insertion: .move(edge: .bottom),
                                        removal: .opacity))
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
            VStack(spacing: 20) {
                emotionListDialog
                CustomTabBar(
                    selectedIndex: $viewModel.seletedTabBarIndex,
                    backgroundColor: .white,
                    selectedItemColor: Theme.current.buttonColor.backgroundColor,
                    unselectedItemColor: .gray,
                    onBigButtonTapped: viewModel.onBigButtonTapped)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isInputViewShow,
                         onDismiss: viewModel.onInputViewDismiss) {
            if let selectedCoreEmotion = viewModel.selectedCoreEmotion {
                InputView(emotion: selectedCoreEmotion)
            } else {
                Color.clear
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
