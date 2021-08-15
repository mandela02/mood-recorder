//
//  DismissAlertView.swift
//  DismissAlertView
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

struct DismissDialog: View {
    typealias Function = () -> ()
    
    var save: Function
    var cancel: Function
    var exit: Function

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
            Text("This diary is not saved")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(Theme.current.commonColor.textColor)
            Text("All data will be lost. Do you want to exit?")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(Theme.current.commonColor.textColor)

            Image(avatar == .dino ? AppImage.dinoCrying.value : AppImage.crying.value)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                createButton(title: "Cancel",
                             callback: cancel)
                createButton(title: "Save and Exit",
                             callback: save)
                createButton(title: "Exit but not save",
                             background: Color.red,
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
