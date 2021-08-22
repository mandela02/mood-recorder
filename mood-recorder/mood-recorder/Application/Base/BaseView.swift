//
//  BaseView.swift
//  BaseView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

struct BaseView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(Keys.themeId.rawValue) var themeId: Int = 0
            
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
        }
        .preferredColorScheme(nil)
        .onAppear(perform: {
            Theme.post(themeId: colorScheme == .dark ? 1 : 0)
        })
        .onChange(of: colorScheme, perform: { newValue in
            Theme.post(themeId: newValue == .dark ? 1 : 0)
        })
    }
}
