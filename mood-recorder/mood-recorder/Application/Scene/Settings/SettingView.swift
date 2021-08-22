//
//  SettingView.swift
//  SettingView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

struct SettingView: View {
    @Binding var isTabBarHiddenNeeded: Bool
    
    @State var isThemeViewShowing = false
    
    private func showTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isTabBarHiddenNeeded = false
        }
    }

    var body: some View {
        BaseView {
            ZStack {
                Theme.current.tableViewColor.background
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Button(action: {
                            isTabBarHiddenNeeded = true
                            isThemeViewShowing = true
                        }) {
                            HStack {
                                Text("Theme")
                                    .foregroundColor(Theme.current.tableViewColor.text)
                                Spacer()
                                Image(systemName: "greaterthan")
                                    .foregroundColor(Theme.current.tableViewColor.text)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .fill(Theme.current.tableViewColor.cellBackground))
                            .padding()
                        }
                    }
                }
            }
        }
        .overlay {
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
