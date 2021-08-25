//
//  ResetDialog.swift
//  ResetDialog
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

struct ResetDialog: View {
    var reset: VoidFunction
    var cancel: VoidFunction

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

    func createButton(title: String,
                      background: Color? = nil,
                      callback: @escaping VoidFunction) -> some View {
        
        let background = background ?? Theme.get(id: themeId).buttonColor.backgroundColor
        
        return Button(action: callback) {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .background(background)
        .cornerRadius(20)
    }

    var body: some View {
        VStack(spacing: 5) {
            Text("You are about to reset this diary")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)

            Text("All data will be lost. Do you want to reset?")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)

            Image(avatar == .dino ? AppImage.surprise.value : AppImage.surprised.value)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                createButton(title: "Reset all option",
                             background: Theme.get(id: themeId).buttonColor.redColor,
                             callback: reset)
                createButton(title: "Cancel",
                             callback: cancel)
            }
            .padding(.horizontal, 30)
        }
    }
}
