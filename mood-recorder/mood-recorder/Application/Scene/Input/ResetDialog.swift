//
//  ResetDialog.swift
//  ResetDialog
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

struct ResetDialog: View {
    typealias Function = () -> ()

    var reset: Function
    var cancel: Function

    func createButton(title: String,
                      background: Color = Theme.current.buttonColor.backgroundColor,
                      callback: @escaping Function) -> some View {
        Button(action: callback) {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Theme.current.buttonColor.textColor)
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
                .foregroundColor(Theme.current.commonColor.textColor)

            Text("All data will be lost. Do you want to reset?")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(Theme.current.commonColor.textColor)


            Image(avatar == .dino ? AppImage.surprise : AppImage.surprised)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                createButton(title: "Reset all option",
                             background: Color.red,
                             callback: reset)
                createButton(title: "Cancel",
                             callback: cancel)
            }
            .padding(.horizontal, 30)
        }
    }
}
