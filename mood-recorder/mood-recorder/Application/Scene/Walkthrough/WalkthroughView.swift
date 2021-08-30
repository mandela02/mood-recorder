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
                    SizedBox(height: 50)
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

struct AvatarSetting: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @AppStorage(Keys.avatar.rawValue)
    var avatarId: Int = 0
    
    var body: some View {
        ZStack {
            Theme.get(id: themeId)
                .commonColor.viewBackground
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                HStack(alignment: .center, spacing: 50) {
                    ForEach(Avatar.allCases, id: \.rawValue) { avatar in
                        Button(action: {
                            Settings.avatar.value = avatar.rawValue
                        }, label: {
                            RoundImageView(image: avatar.image,
                                           backgroundColor: avatar.rawValue == avatarId ?
                                           Theme.get(id: themeId).buttonColor.backgroundColor :
                                            Theme.get(id: themeId).buttonColor.disableColor,
                                           padding: 20)
                                .frame(width: 100, height: 100, alignment: .center)
                        })
                    }
                }
                
                SizedBox(height: 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("AVATAR")
                        .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                        .font(.largeTitle.bold())
                    Text("Are you a pineapple or a dino?")
                        .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .padding(.all, 20)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                SizedBox(height: 10)
            }
        }
    }
}
