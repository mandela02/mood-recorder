//
//  CalendarView.swift
//  CalendarView
//
//  Created by TriBQ on 8/20/21.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject
    var viewModel: BaseViewModel<CalendarState,
                                 CalendarTrigger>
    
    @Binding
    var isTabBarHiddenNeeded: Bool
    
    @State
    var isDiaryViewShowing = false
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

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
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Theme.get(id: themeId).commonColor.viewBackground
                .ignoresSafeArea()
            VStack {
                buildDateView()
                ScrollView {
                    VStack {
                        buildCalendar()
                            .padding()
                        
                        if viewModel.state.isDetailViewShowing,
                           let diary = viewModel.state.selectedDiaryDataModel {
                            CalendarDiaryDetailView(diary: diary,
                                                    onEditDiary: {
                                viewModel.trigger(.edit)
                            }, onDeleteDiary: {
                                viewModel.trigger(.delete)
                            })
                                .id(diary.date)
                        }
                        
                        SizedBox(height: 150)
                    }
                    .clipped()
                }
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
                        viewModel.trigger(.deselectDate)
                        viewModel.trigger(.closeDatePicker)
                        viewModel.trigger(.goTo(month: month, year: year))
                        viewModel.trigger(.reload)
                        showTabBar()
                    },
                    onCancel: {
                        viewModel.trigger(.closeDatePicker)
                        showTabBar()
                    })
            }
        }
        .customDialog(isShowing: viewModel.state.isFutureWarningDialogShow,
                      dialogContent: {
            if let model = viewModel.state.selectedDiaryDataModel {
                FutureWarningDialog(date: model.date) {
                    viewModel.trigger(.closeFutureDialog)
                }
            }
        })
        .onChange(of: viewModel.state.isDiaryViewShowing, perform: { newValue in
            self.isDiaryViewShowing = viewModel.state.isDiaryViewShowing
        })
        .fullScreenCover(isPresented: $isDiaryViewShowing,
                         onDismiss: {
            viewModel.trigger(.closeDiaryView)
            viewModel.trigger(.reload)
        },
                         content: {
            if let data = viewModel.state.selectedDiaryDataModel {
                DiaryView(data: data)
            } else {
                Color.clear
            }
        })
        .task {
            viewModel.trigger(.goToToDay)
            viewModel.trigger(.reload)
        }
        .animation(.easeInOut, value: viewModel.state.isDatePickerShow)
        .animation(.easeInOut, value: viewModel.state.isDetailViewShowing)
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
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            }
        })
    }
    
    private func buildCalendarDays(models: [DiaryDataModel]) -> some View {
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
                        if date.isInSameDay(as: viewModel.state.selectedDiaryDataModel?.date ?? Date()) {
                            ZStack {
                                Theme.get(id: themeId).buttonColor.backgroundColor
                                    .clipShape(Capsule())
                                    .padding(.horizontal, 5)
                                Text("\(date.day)")
                                    .font(.system(size: 10))
                                    .padding(.all, 5)
                                    .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                            }
                        } else {
                            Text("\(date.day)")
                                .font(.system(size: 10))
                                .padding(.all, 5)
                                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                        }
                        
                        Button(action: {
                            viewModel.trigger(.dateSelection(model: model))
                        }, label: {
                            if date.isInTheFuture {
                                Theme.get(id: themeId).buttonColor.disableColor
                                    .clipShape(Circle())
                                    .aspectRatio(1, contentMode: .fit)
                            } else {
                                if let emotion = model.emotion {
                                    RoundImageView(image: emotion.image,
                                                   backgroundColor: Theme.get(id: themeId).buttonColor.backgroundColor)
                                } else {
                                    Theme.get(id: themeId).buttonColor.disableColor
                                        .clipShape(Circle())
                                        .overlay(Circle()
                                                    .stroke(Theme.get(id: themeId).buttonColor.backgroundColor,
                                                            lineWidth: 2))
                                        .aspectRatio(1, contentMode: .fit)
                                }
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
        .animation(.easeInOut, value: viewModel.state.selectedDiaryDataModel?.date)
    }
}

extension CalendarView {
    func buildDateView() -> some View {
        HStack {
            Button(action: {
                viewModel.trigger(.share)
            }, label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 30)
                    .scaleEffect(0.8)
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            })
                        
            DateNavigationView(month: viewModel.state.currentMonth.month,
                               year: viewModel.state.currentMonth.year,
                               goToNextMonth: {
                viewModel.trigger(.deselectDate)
                viewModel.trigger(.goToNextMonth)
                viewModel.trigger(.reload)
            },
                               goToLastMonth: {
                viewModel.trigger(.deselectDate)
                viewModel.trigger(.backToLaseMonth)
                viewModel.trigger(.reload)
            }, onDateTap: {
                isTabBarHiddenNeeded = true
                viewModel.trigger(.showDatePicker)
            })
                        
            Button(action: {
                viewModel.trigger(.goToToDay)
                viewModel.trigger(.reload)
            }, label: {
                Text("Today")
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                    .frame(width: 50)
            })
        }
        .padding(.horizontal, 10)
    }
}