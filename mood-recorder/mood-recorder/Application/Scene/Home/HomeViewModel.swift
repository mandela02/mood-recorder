//
//  HomeViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

class HomeViewModel: ViewModel {
    @Published
    var state: HomeState
            
    init(state: HomeState) {
        self.state = state
    }
    
    func trigger(_ input: HomeTrigger) {
        switch input {
        case .selectEmotion(let emotion):
            state.selectedEmotion = emotion
        case .deselectEmotion:
            state.selectedEmotion = nil
        case .handleDiaryView(let status):
            state.isDiaryShow = status == .open
        case .handleEmotionDialog(let status):
            state.isEmotionDialogShowing = status == .open
        case .handleTab(index: let index):
            state.seletedTabBarView = TabBarView(rawValue: index) ?? .calendar
        }
    }
}

extension HomeViewModel {
    enum ViewStatus {
        case open
        case close
    }
    
    enum TabBarView: Int {
        case calendar
        case timeline
        case chart
        case setting
    }
    
    struct HomeState {
        var calendarViewModel: BaseViewModel<CalendarState,
                                             CalendarTrigger>
        
        var chartViewModel: BaseViewModel<ChartState,
                                          ChartTrigger>

        var diaryViewModel: BaseViewModel<DiaryState,
                                        DiaryTrigger>
        
        var selectedEmotion: CoreEmotion?
        
        var isDiaryShow = false
        var isEmotionDialogShowing = false
        var seletedTabBarView: TabBarView = .calendar
        
        init() {
            calendarViewModel = BaseViewModel(CalendarViewModel(state: CalendarState()))
            chartViewModel = BaseViewModel(ChartViewModel(state: ChartState()))
            diaryViewModel = BaseViewModel(DiaryViewModel(state: DiaryState()))
        }
    }
    
    enum HomeTrigger {
        case selectEmotion(emotion: CoreEmotion)
        case deselectEmotion
        case handleDiaryView(status: ViewStatus)
        case handleEmotionDialog(status: ViewStatus)
        case handleTab(index: Int)
    }
}
