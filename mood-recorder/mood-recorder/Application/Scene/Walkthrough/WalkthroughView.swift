//
//  WalkthroughView.swift
//  WalkthroughView
//
//  Created by TriBQ on 8/29/21.
//

import SwiftUI

struct WalkthroughView: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @State
    var index: Int = 0
    
    @State
    var offset: CGFloat = 0
    
    func buildPagerView() -> some View {
        return PagerView(index: $index,
                         offset: $offset,
                         pageCount: 3) {
            WalkthroughTab.avatar.view
            WalkthroughTab.notification.view
            WalkthroughTab.theme.view
        }
    }
    
    func buildPageControll(maxWidth: CGFloat) -> some View {
        let width = getIndicatorOffset(maxWidth: maxWidth)
        return HStack(spacing: 12) {
            ForEach(WalkthroughTab.allCases.indices, id: \.self) { index in
                Capsule()
                    .fill(Theme.get(id: themeId).buttonColor.backgroundColor)
                    .frame(width: index == self.index ? 20 : 7, height: 7)
            }
        }
        .overlay(Capsule()
                    .fill(Theme.get(id: themeId).buttonColor.backgroundColor)
                    .frame(width: 20, height: 7)
                    .offset(x: -width), alignment: .leading)
        .animation(.linear, value: width)
    }
    
    func getIndicatorOffset(maxWidth: CGFloat) -> CGFloat {
        let progress = offset / maxWidth
        return progress * (12 + 7)
    }
    
    func buildNextButton() -> some View {
        return Button(action: {
            if index < WalkthroughTab.allCases.count - 1 {
                index += 1
            }
        }, label: {
            Image(systemName: "chevron.right")
                .font(.title2.bold())
                .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                .padding(10)
                .background(WalkthroughTab(rawValue: index)?.color ?? .clear,
                            in: Circle())
                .animation(.easeInOut, value: index)
        })
    }
    
    var body: some View {
        ZStack {
            Theme.get(id: themeId).commonColor.viewBackground
                .ignoresSafeArea()
            GeometryReader { proxy in
                VStack {
                    buildPagerView()
                        .frame(width: proxy.size.width)
                    HStack {
                        buildPageControll(maxWidth: proxy.size.width)
                        Spacer()
                        buildNextButton()
                    }.frame(height: 50)
                        .padding(EdgeInsets(top: 20,
                                            leading: 20,
                                            bottom: 10,
                                            trailing: 20))
                    SizedBox(height: 50)
                }
            }
        }
    }
}

enum WalkthroughTab: Int, CaseIterable {
    case avatar
    case notification
    case theme
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .avatar:
            AvatarSetting()
        case .notification:
            NotificationSetting()
        case .theme:
            Color.yellow
        }
    }
    
    var color: Color {
        switch self {
        case .avatar:
            return Color.red
        case .notification:
            return Color.blue
        case .theme:
            return Color.yellow
        }
    }
}

struct WalkthroughContentView: View, Identifiable {
    @Binding var selectedIndex: Int
    var tab: WalkthroughTab
    
    var id = UUID()
    
    var body: some View {
        tab.view
    }
}
