//
//  ThemeSetting.swift
//  ThemeSetting
//
//  Created by TriBQ on 8/31/21.
//

import SwiftUI

struct ThemeSetting: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value
        
    @State
    var isOn: Bool = false

    func buildText() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("THEME")
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                .font(.largeTitle.bold())
                .shadow(color: Theme.get(id: themeId).commonColor.viewBackground,
                        radius: 1)
            Text("Choose, you must. Light side or Dark Side?")
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                .font(.subheadline)
                .fontWeight(.semibold)
                .shadow(color: Theme.get(id: themeId).commonColor.viewBackground,
                        radius: 1)
        }
    }
    
    func buildSwitch() -> some View {
        HStack {
            Text("Enable Dark Mode")
                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: Theme.get(id: themeId).buttonColor.disableColor))
        }
        .padding()
    }

    var body: some View {
        ZStack {
            Theme.get(id: themeId).commonColor.viewBackground
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 10) {
                Spacer()
                
                buildSwitch()

                buildText()
                .padding(.all, 20)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                SizedBox(height: 10)
            }
        }
        .onChange(of: isOn) { newValue in
            Theme.post(themeId: newValue ? 1 : 0)
        }
        .onAppear(perform: {
            self.isOn = themeId == 1
        })
        .animation(Animation.easeInOut(duration: 0.5), value: isOn)
    }
}

struct ThemeSetting_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSetting()
    }
}
