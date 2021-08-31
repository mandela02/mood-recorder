//
//  DismissAlertView.swift
//  DismissAlertView
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

struct DismissDialog: View {
    var save: VoidFunction
    var cancel: VoidFunction
    var exit: VoidFunction

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value

    func createButton(title: String,
                      background: Color,
                      callback: @escaping VoidFunction) -> some View {
        Button(action: callback) {
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
            Text("This diary is not saved")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            Text("All data will be lost. Do you want to exit?")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)

            Image(Avatar.get() == .dino ? AppImage.dinoCrying.value : AppImage.crying.value)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                createButton(title: "Cancel",
                             background: Theme.get(id: themeId).buttonColor.backgroundColor,
                             callback: cancel)
                createButton(title: "Save and Exit",
                             background: Theme.get(id: themeId).buttonColor.backgroundColor,
                             callback: save)
                createButton(title: "Exit but not save",
                             background: Theme.get(id: themeId).buttonColor.redColor,
                             callback: exit)
            }
            .padding(.horizontal, 30)
        }
    }
}

struct DismissAlertView_Previews: PreviewProvider {
    static var previews: some View {
        DismissDialog(save: {},
                         cancel: {},
                         exit: {})
    }
}
