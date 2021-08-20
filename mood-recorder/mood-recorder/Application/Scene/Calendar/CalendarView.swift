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
    
    @ObservedObject var viewModel: BaseViewModel<CalendarState,
                                                 CalendarTrigger>
    
    init(viewModel: BaseViewModel<CalendarState, CalendarTrigger>) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Theme.current.commonColor.viewBackground
                .ignoresSafeArea()
            VStack {
                buildDateView()
                buildCalendar()
                    .padding()
            }
        }
    }
}

// MARK: - Calendar View
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
                if date.month == viewModel.state.currentMonth.month &&
                    date.year == viewModel.state.currentMonth.year {
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
                                    .overlay(Circle()
                                                .stroke(Theme.current.buttonColor.backgroundColor,
                                                        lineWidth: 2))
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

extension CalendarView {
    func buildDateView() -> some View {
        HStack {
            Button(action: {
                viewModel.trigger(.backToLaseMonth)
            }) {
                Image(systemName: "arrowtriangle.backward.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(Theme.current.buttonColor.backgroundColor)
            }
            
            Text("\(viewModel.state.currentMonth.month)/\(String(viewModel.state.currentMonth.year))")
                .foregroundColor(Theme.current.buttonColor.textColor)
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Theme.current.buttonColor.backgroundColor))
                .padding(.horizontal, 30)
            
            Button(action: {
                viewModel.trigger(.goToNextMonth)
            }) {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(Theme.current.buttonColor.backgroundColor)
            }
        }
    }
}
