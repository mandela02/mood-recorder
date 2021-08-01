//
//  HomeViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var seletedTabBarIndex = 0
    @Published var isEmotionDialogShowing = false
    
    func onBigButtonTapped() {
        withAnimation(.spring()) {
            isEmotionDialogShowing.toggle()
        }
    }
}
