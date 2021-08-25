//
//  ContentView.swift
//  mood-recorder
//
//  Created by LanNTH on 01/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @AppStorage(Keys.isUsingSystemTheme.rawValue)
    var isUsingSystemTheme: Bool = false

    @Environment(\.colorScheme)
    var colorScheme
    
    var viewModel: BaseViewModel<HomeState, HomeTrigger>
    
    init() {
        viewModel = BaseViewModel(HomeViewModel(state: HomeState()))
    }

    var body: some View {
        HomeView(viewModel: viewModel)
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
            .onChange(of: themeId) { newValue in
                UIPageControl.appearance()
                    .currentPageIndicatorTintColor =
                UIColor(Theme.get(id: newValue).buttonColor.backgroundColor)
                
                UIPageControl.appearance()
                    .pageIndicatorTintColor =
                UIColor(Theme.get(id: newValue).buttonColor.disableColor)
            }
    }
}
