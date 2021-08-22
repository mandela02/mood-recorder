//
//  HomeViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published
    var seletedTabBarIndex = 0
    
    @Published
    var isEmotionDialogShowing = false
    
    @Published
    var isInputViewShow = false
    
    @Published
    var isTabBarHiddenNeeded = false

    var calendarViewModel: BaseViewModel<CalendarState,
                                         CalendarTrigger>
    
    var chartViewModel: BaseViewModel<ChartState,
                                      ChartTrigger>
    
    var selectedCoreEmotion: CoreEmotion?
    
    init() {
        calendarViewModel = BaseViewModel(CalendarViewModel(state: CalendarState()))
        chartViewModel = BaseViewModel(ChartViewModel(state: ChartState()))
    }
    
    func onBigButtonTapped() {
        isEmotionDialogShowing.toggle()
    }
    
    func onInputViewDismiss() {
        selectedCoreEmotion = nil
    }
    
    func onEmotionSelected(emotion: CoreEmotion) {
        onBigButtonTapped()
        selectedCoreEmotion = emotion
        isInputViewShow.toggle()
    }
}
