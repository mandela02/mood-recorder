//
//  HourPicker.swift
//  HourPicker
//
//  Created by TriBQ on 8/30/21.
//

import SwiftUI

struct HourPicker: View {
    @State
    private var selectedHour: Int
    
    @State
    private var selectedMinute: Int
    
    @State
    private var isAppear = false
    
    private let minutes = 0...59
    
    private let hours = 0...23

    var onApply: IntTupleCallbackFunction
    
    var onCancel: VoidFunction

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value

    init(hour: Int,
         minute: Int,
         onApply: @escaping IntTupleCallbackFunction,
         onCancel: @escaping VoidFunction) {
        self.selectedHour = hour
        self.selectedMinute = minute
        self.onApply = onApply
        self.onCancel = onCancel
    }
    
    func buildPicker() -> some View {
        GeometryReader { proxy in
            let width = proxy.size.width / 4
            
            HStack {
                Picker("Select Hour",
                       selection: $selectedHour) {
                    ForEach(hours, id: \.self) {
                        Text("\(String($0))")
                    }
                }
                       .pickerStyle(WheelPickerStyle())
                       .frame(maxWidth: width)
                       .clipped()
                
                Text("Hour")
                    .font(.system(size: 15))
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
                    .frame(maxWidth: width)

                Picker("Select Minute",
                       selection: $selectedMinute) {
                    ForEach(minutes, id: \.self) {
                        Text("\(String($0))")
                    }
                }
                       .pickerStyle(WheelPickerStyle())
                       .frame(maxWidth: width)
                       .clipped()
                
                Text("Minutes")
                    .font(.system(size: 15))
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
                    .frame(maxWidth: width)
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
            }, label: {
                Text("Cancel")
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
            })
            
            Spacer()
            
            Button(action: {
                isAppear = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    onApply(selectedHour, selectedMinute)
                }
            }, label: {
                Text("Apply")
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
            })
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
