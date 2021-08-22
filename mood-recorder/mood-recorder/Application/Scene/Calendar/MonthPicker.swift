//
//  MonthPicker.swift
//  MonthPicker
//
//  Created by TriBQ on 8/20/21.
//

import SwiftUI

enum Month: Int, CaseIterable, StringValueProtocol {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    
    var value: String {
        switch self {
        case .january:
            return "January"
        case .february:
            return "February"
        case .march:
            return "March"
        case .april:
            return "April"
        case .may:
            return "May"
        case .june:
            return "June"
        case .july:
            return "July"
        case .august:
            return "August"
        case .september:
            return "September"
        case .october:
            return "October"
        case .november:
            return "November"
        case .december:
            return "December"
        }
    }
}

struct MonthPicker: View {
    @State private var selectedMonth: Month
    @State private var selectedYear: Int
    @State private var isAppear = false
    
    private let years = 1980...2099
    
    var onApply: IntTupleCallbackFunction
    var onCancel: VoidFunction

    @AppStorage(Keys.themeId.rawValue) var themeId: Int = 0

    init(month: Int,
         year: Int,
         onApply: @escaping IntTupleCallbackFunction,
         onCancel: @escaping VoidFunction) {
        self.selectedMonth = Month(rawValue: month) ?? .january
        self.selectedYear = year
        self.onApply = onApply
        self.onCancel = onCancel
    }
    
    func buildPicker() -> some View {
        GeometryReader { proxy in
            HStack {
                Picker("SelectMonth",
                       selection: $selectedMonth) {
                    ForEach(Month.allCases, id: \.self) {
                        Text($0.value)
                    }
                }
                       .pickerStyle(WheelPickerStyle())
                       .frame(maxWidth: proxy.size.width / 2)
                       .clipped()
                
                Spacer()
                Picker("SelectMonth",
                       selection: $selectedYear) {
                    ForEach(years, id: \.self) {
                        Text("\(String($0))")
                    }
                }
                       .pickerStyle(WheelPickerStyle())
                       .frame(maxWidth: proxy.size.width / 2)
                       .clipped()
            }
        }
    }
    
    func buildButton() -> some View {
        HStack {
            Button(action: {
                isAppear = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    onCancel()
                }
            }) {
                Text("Cancel")
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
            }
            
            Spacer()
            
            Button(action: {
                onApply(selectedMonth.rawValue, selectedYear)
            }) {
                Text("Apply")
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack {
                Spacer()
                if isAppear {
                    ZStack {
                        Theme.get(id: themeId).commonColor.dialogBackground
                            .cornerRadius(20)
                            .ignoresSafeArea()
                        VStack {
                            buildButton()
                                .padding(EdgeInsets(top: 20,
                                                    leading: 30,
                                                    bottom: 10,
                                                    trailing: 30))
                            buildPicker()
                        }
                    }
                    .transition(.move(edge: .bottom))
                    .frame(height: UIScreen.main.bounds.height / 3,
                           alignment: .center)
                }
            }
        }.onAppear {
            isAppear = true
        }
        .animation(.easeInOut, value: isAppear)
    }
}
