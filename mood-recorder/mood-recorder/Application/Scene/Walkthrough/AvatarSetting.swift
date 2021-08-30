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
