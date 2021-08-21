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
    @Binding var isTabBarHiddenNeeded: Bool
        
    init(viewModel: BaseViewModel<CalendarState, CalendarTrigger>,
         isTabBarHiddenNeeded: Binding<Bool>) {
        self.viewModel = viewModel
        self._isTabBarHiddenNeeded = isTabBarHiddenNeeded
    }
    
    private func showTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isTabBarHiddenNeeded = false
        }
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
        .onChange(of: viewModel.state.isFutureWarningDialogShow,
                  perform: { newValue in
            isTabBarHiddenNeeded = newValue
        })
        .overlay {
            if viewModel.state.isDatePickerShow {
                MonthPicker(
                    month: viewModel.currentMonth.month,
                    year: viewModel.currentMonth.year,
                    onApply: { (month, year) in
                    viewModel.trigger(.goTo(month: month, year: year))
                    viewModel.trigger(.closeDatePicker)
                    showTabBar()
                },
                    onCancel: {
                    viewModel.trigger(.closeDatePicker)
                    showTabBar()
                })
            }
        }
        .animation(.easeInOut, value: viewModel.state.isDatePickerShow)
        .customDialog(isShowing: viewModel.state.isFutureWarningDialogShow,
                      dialogContent: {
            if let date = viewModel.state.selectedDate {
                FutureWarningDialog(date: date) {
                    viewModel.trigger(.closeFutureDialog)
                    viewModel.trigger(.deselectDate)
                }
            }
        })
        //.animation(.easeInOut, value: isFutureWarningDialogShow)
    }
}

// MARK: - Calendar View
extension CalendarView {
    private func buildCalendar() -> some View {
        VStack(spacing: 10) {
            buildWeekDay()
            buildCalendarDays(models: viewModel.state.diaries)
                .animation(.easeInOut(duration: 0.2), value: viewModel.state.currentMonth.month)
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
    
    private func buildCalendarDays(models: [InputDataModel]) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     alignment: .top),
                                 count: 7),
                  spacing: 10,
                  content: {
            ForEach(Array(models.enumerated()),
                    id: \.offset) { index, model in
                let date = model.date
                
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
                viewModel.trigger(.share)
            }) {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 30)
                    .foregroundColor(Theme.current.buttonColor.backgroundColor)
            }

            Spacer()
            
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
                .padding(.horizontal, 10)
                .onTapGesture {
                    isTabBarHiddenNeeded = true
                    viewModel.trigger(.showDatePicker)
                }
            
            Button(action: {
                viewModel.trigger(.goToNextMonth)
            }) {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(Theme.current.buttonColor.backgroundColor)
            }
            
            Spacer()

            Button(action: {
                viewModel.trigger(.goToToDay)
            }) {
                Text("Today")
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .foregroundColor(Theme.current.commonColor.textColor)
                    .frame(width: 50)
            }
        }
        .padding(.horizontal, 10)
    }
}
