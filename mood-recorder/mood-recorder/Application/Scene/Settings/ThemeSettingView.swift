//
//  SettingView.swift
//  SettingView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

struct ThemeSettingView: View {
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @AppStorage(Keys.isUsingSystemTheme.rawValue)
    var isUsingSystemTheme: Bool = false

    @Environment(\.colorScheme)
    var colorScheme

    @State
    var isOn: Bool = false
    
    let onClose: VoidFunction
   
    init(onClose: @escaping VoidFunction) {
        self.onClose = onClose
    }
    
    func buildCloseButton() -> some View {
        HStack {
            Button(action: onClose) {
                Image(systemName: "xmark")
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            }
            .padding()
            Spacer()
        }
    }
    
    func buildSystemSettingButton() -> some View {
        HStack {
            Text("Using system setting?")
                .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
            Spacer()
            Toggle("", isOn: $isUsingSystemTheme)
                .toggleStyle(SwitchToggleStyle(tint: Theme.get(id: themeId).buttonColor.disableColor))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Theme.get(id: themeId).tableViewColor.cellBackground))
        .padding()
    }
    
    func buildThemeSwitchButton() -> some View {
        HStack {
            Text("Dark Mode")
                .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: Theme.get(id: themeId).buttonColor.disableColor))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Theme.get(id: themeId).tableViewColor.cellBackground))
        .padding()
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Color.yellow
                .opacity( isOn ? 0 : 0.2)
                .ignoresSafeArea()
            Color.black
                .opacity( isOn ? 0.7 : 0)
                .ignoresSafeArea()
            VStack(spacing: 5) {
                buildCloseButton()
                SizedBox(height: 5)
                buildSystemSettingButton()
                buildThemeSwitchButton()
                Spacer()
            }
            AnimatedSwitch(isOn: $isOn)
                .onTapGesture(count: 1, perform: {
                    isOn.toggle()
                })
                .onChange(of: isOn) { newValue in
                    Theme.post(themeId: newValue ? 1 : 0)
                }
                .onChange(of: themeId) { newValue in
                    isOn = newValue == 1
                }
                .offset(y: 5)
        }
        .onChange(of: isUsingSystemTheme, perform: { newValue in
            if newValue {
                Theme.post(themeId: colorScheme == .dark ? 1 : 0)
            }
        })
        .onAppear(perform: {
            self.isOn = themeId == 1
        })
        .animation(Animation.easeInOut(duration: 0.5), value: isOn)
    }
}
