//
//  SettingView.swift
//  SettingView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

struct ThemeSettingView: View {
    @AppStorage(Keys.themeId.rawValue) var themeId: Int = 0

    @State var isOn: Bool = false
    
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
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Color.yellow
                .opacity( isOn ? 0 : 0.2)
                .ignoresSafeArea()
            Color.black
                .opacity( isOn ? 0.7 : 0)
                .ignoresSafeArea()
            VStack {
                buildCloseButton()
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
        }
        .onAppear(perform: {
            self.isOn = themeId == 1
        })
        .animation(Animation.easeInOut(duration: 0.5), value: isOn)
    }
}
