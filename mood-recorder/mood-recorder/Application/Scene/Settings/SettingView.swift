//
//  SettingView.swift
//  SettingView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value
    
    @State
    var isThemeViewShowing = false
    
    @Binding
    var isTabBarHiddenNeeded: Bool

    private func showTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isTabBarHiddenNeeded = false
        }
    }

    var body: some View {
        ZStack {
            Theme.get(id: themeId).tableViewColor.background
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Button(action: {
                        isTabBarHiddenNeeded = true
                        isThemeViewShowing = true
                    }, label: {
                        HStack {
                            Text("Theme")
                                .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Theme.get(id: themeId).tableViewColor.cellBackground))
                        .padding()
                    })
                }
            }
        }.overlay {
            if isThemeViewShowing {
                ThemeSettingView(onClose: {
                    isThemeViewShowing = false
                    showTabBar()
                })
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut, value: isThemeViewShowing)
    }
}
