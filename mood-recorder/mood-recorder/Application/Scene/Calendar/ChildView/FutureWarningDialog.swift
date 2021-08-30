//
//  FutureWarningDialog.swift
//  FutureWarningDialog
//
//  Created by TriBQ on 8/21/21.
//

import SwiftUI

struct FutureWarningDialog: View {
    var date: Date
    var onCancel: VoidFunction
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

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
            Text("Wait, something wrong.")
                .fontWeight(.bold)
                .font(.system(size: 25))
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)

            Text("Today is \(Date().dayMonthYearString)\nAnd you just select")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                .minimumScaleFactor(0.1)
                .lineLimit(2)
            
            Text(date.dayMonthYearString)
                .fontWeight(.bold)
                .font(.system(size: 22))
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                .minimumScaleFactor(0.1)
                .lineLimit(1)

            Image(Avatar.get() == .dino ? AppImage.space.value : AppImage.astronaut.value)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            Text("You can't predict your future. It's a myth. \nEnjoy your present")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.1)
                .lineLimit(2)
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                .padding()

            createButton(title: "Cancel",
                         background: Theme.get(id: themeId).buttonColor.backgroundColor,
                         callback: onCancel)
                .padding(.horizontal, 30)
        }
        .padding()
    }
}

struct FutureWarningDialog_Previews: PreviewProvider {
    static var previews: some View {
        FutureWarningDialog(date: Date(),
                            onCancel: {})
    }
}
