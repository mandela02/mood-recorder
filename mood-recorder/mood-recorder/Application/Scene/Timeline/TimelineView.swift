//
//  TimelineView.swift
//  TimelineView
//
//  Created by TriBQ on 8/26/21.
//

import SwiftUI

struct TimelineView: View {
    @ObservedObject
    var viewModel: BaseViewModel<TimelineState,
                                 TimelineStrigger>
            
    @Binding
    var isTabBarHiddenNeeded: Bool

    let onDiarySelected: DiaryModelCallbackFunction

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value

    private func showTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isTabBarHiddenNeeded = false
        }
    }
    
    private func hideTabBar() {
        isTabBarHiddenNeeded = true
    }

    var body: some View {
        return ZStack {
            Theme.get(id: themeId).commonColor.viewBackground
                .ignoresSafeArea()
            VStack {
                buildDateView()
                buildList()
                Spacer()
            }
        }
        .task {
            viewModel.trigger(.reload)
        }
        .overlay {
            if viewModel.state.isDatePickerShow {
                MonthPicker(
                    month: viewModel.currentMonth.month,
                    year: viewModel.currentMonth.year,
                    onApply: { (month, year) in
                        viewModel.trigger(.handelDatePickerView(status: .close))
                        viewModel.trigger(.goTo(month: month, year: year))
                        viewModel.trigger(.reload)
                    },
                    onCancel: {
                        viewModel.trigger(.handelDatePickerView(status: .close))
                    })
            }
        }
        .onChange(of: viewModel.isDatePickerShow) { newValue in
            if newValue {
                hideTabBar()
            } else {
                showTabBar()
            }
        }
    }
}

extension TimelineView {
    private func buildCell(diary: DiaryDataModel) -> some View {
        Section(footer: SizedBox(height: diary.id == viewModel.state.lastDiary.id ?
                                 100 : .leastNonzeroMagnitude)) {
            CalendarDiaryDetailView(diary: diary,
                                    isButtonNeeded: false)
                .buttonStyle(PlainButtonStyle())
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                    Button {
                        onDiarySelected(diary)
                    } label: {
                        Label("Edit", systemImage: "pencil")
                            .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                    }
                    .tint(Theme.get(id: themeId).buttonColor.backgroundColor)

                    Button {
                        viewModel.trigger(.onDeleteDiary(diary: diary))
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                            .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                    }
                    .tint(Theme.get(id: themeId).buttonColor.redColor)
                })
        }
    }
    
    private func buildList() -> some View {
        List {
            ForEach(Array(viewModel.state.diaries),
                    id: \.id) { diary in
                buildCell(diary: diary)
            }
        }
        .listStyle(.insetGrouped)
    }
}
extension TimelineView {
    func buildDateView() -> some View {
        HStack {
            SizedBox(height: 30, width: 50)
                        
            DateNavigationView(month: viewModel.state.currentMonth.month,
                               year: viewModel.state.currentMonth.year,
                               goToNextMonth: {
                viewModel.trigger(.goToNextMonth)
                viewModel.trigger(.reload)
            },
                               goToLastMonth: {
                viewModel.trigger(.backToLaseMonth)
                viewModel.trigger(.reload)
            },
                               onDateTap: {
                viewModel.trigger(.handelDatePickerView(status: .open))
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
