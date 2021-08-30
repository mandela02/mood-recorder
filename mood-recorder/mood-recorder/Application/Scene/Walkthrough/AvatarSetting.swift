//
//  AvatarSetting.swift
//  AvatarSetting
//
//  Created by TriBQ on 8/30/21.
//

import SwiftUI

struct AvatarSetting: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @AppStorage(Keys.avatar.rawValue)
    var avatarId: Int = 0
    
    func buildText() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("AVATAR")
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                .font(.largeTitle.bold())
                .shadow(color: Theme.get(id: themeId).commonColor.viewBackground,
                        radius: 1)
            Text("Are you a pineapple or a dino?")
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .shadow(color: Theme.get(id: themeId).commonColor.viewBackground,
                        radius: 1)
        }
    }
    
    func buildButton() -> some View {
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
                        .overlay(Circle()
                                    .stroke(Theme.get(id: themeId).buttonColor.backgroundColor,
                                            lineWidth: 2))
                })
            }
        }
    }
    
    func buildImage() -> some View {
        let avatar = Avatar.get(id: avatarId)
        switch avatar {
        case .dino:
            return avatar.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: 60)
                .scaleEffect(1.4)
        case .pineapple:
            return avatar.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: -60)
                .scaleEffect(1.4)
        }
    }
    
    var body: some View {
        ZStack {
            Theme.get(id: themeId)
                .commonColor.viewBackground
                .ignoresSafeArea()
            
            buildImage()

            VStack(alignment: .center, spacing: 10) {
                Spacer()
                
                buildButton()
                
                SizedBox(height: 10)
                
                buildText()
                .padding(.all, 20)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                SizedBox(height: 10)
            }
        }
        .animation(.spring(), value: avatarId)
    }
}
