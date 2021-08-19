//
//  CalendarView.swift
//  CalendarView
//
//  Created by TriBQ on 8/20/21.
//

import SwiftUI

struct CalendarView: View {
    typealias CalendarState = CalendarViewModel.CalendarState
    typealias CalendarTrigger = CalendarViewModel.CalendarTrigger
    
    let viewModel: BaseViewModel<CalendarState, CalendarTrigger>
    
    init() {
        let viewModel = BaseViewModel(CalendarViewModel(state: CalendarState()))
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Theme.current.commonColor.viewBackground
                .ignoresSafeArea()
            buildCalendar()
                .padding()
        }
    }
}

extension CalendarView {
    private func buildCalendar() -> some View {
        VStack(spacing: 10) {
            buildWeekDay()
            buildCalendarDays(dates: viewModel.state.dates)
            Spacer()
        }
    }
    
    private func buildWeekDay() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 7),
                  content: {
            ForEach(WeekDay.allCases, id: \.rawValue) { day in
                Text(day.value)
                    .font(.system(size: 15))
                    .foregroundColor(Theme.current.commonColor.textColor)
            }
        })
    }
    
    private func buildCalendarDays(dates: [Date]) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 7),
                  spacing: 10,
                  content: {
            ForEach(Array(dates.enumerated()),
                    id: \.offset) { index, date in
                if date.isInSameMonth(as: Date()) {
                    LazyVStack(spacing: 5) {
                        if date.isInSameDay(as: Date()) {
                            ZStack {
                                Theme.current.buttonColor.backgroundColor
                                    .clipShape(Capsule())
                                    .padding(.horizontal, 5)
                                Text("\(date.day)")
                                    .font(.system(size: 10))
                                    .padding(.all, 5)
                                    .foregroundColor(Theme.current.buttonColor.textColor)
                            }
                        } else {
                            Text("\(date.day)")
                                .font(.system(size: 10))
                                .padding(.all, 5)
                                .foregroundColor(Theme.current.commonColor.textColor)
                        }
                        
                        Button(action: {
                            viewModel.trigger(.dateSelection(date: date))
                        }, label: {
                            if date.isInTheFuture {
                                Theme.current.buttonColor.disableColor
                                    .clipShape(Circle())
                                    .aspectRatio(1, contentMode: .fit)
                            } else {
                                RoundImageView(image: AppImage.dinoInlove.value.image,
                                               backgroundColor: Theme.current.buttonColor.disableColor)
                            }
                        })
                            .aspectRatio(1, contentMode: .fit)
                            .buttonStyle(ResizeAnimationButtonStyle())
                    }
                } else {
                    Color.clear
                }
            }
        })
    }
}
