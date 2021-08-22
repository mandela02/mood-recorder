//
//  BaseView.swift
//  BaseView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

public class ForceUpdateViewModel: ObservableObject {
    func updateView(){
        self.objectWillChange.send()
    }
}

struct BaseView<Content: View>: View {
    @AppStorage(Keys.themeId.rawValue) var themeId: Int = 0
    
    @ObservedObject var viewModel = ForceUpdateViewModel()
        
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
        }
        .onChange(of: themeId, perform: { newValue in
            viewModel.updateView()
        })
    }
}
