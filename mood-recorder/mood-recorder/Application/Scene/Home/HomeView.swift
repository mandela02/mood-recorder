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

    var tintForeGroundColor: Color {
        viewModel.isEmotionDialogShowing ? Color.black.opacity(0.5) : .clear
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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabView
                .ignoresSafeArea()
            tintForeGroundColor
                .ignoresSafeArea()
            CustomTabBar(
                selectedIndex: $viewModel.seletedTabBarIndex,
                backgroundColor: .white,
                selectedItemColor: .green,
                unselectedItemColor: .gray,
                onBigButtonTapped: viewModel.onBigButtonTapped)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
