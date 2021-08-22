//
//  DateNavigationView.swift
//  DateNavigationView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct DateNavigationView: View {
    let month: Int
    let year: Int
    
    let goToNextMonth: VoidFunction
    let goToLastMonth: VoidFunction
    let onDateTap: VoidFunction

    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

    var body: some View {
        HStack {
            Spacer()
            
            Button(action: goToLastMonth, label: {
                Image(systemName: "arrowtriangle.backward.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
            })
            
            Text("\(month)/\(String(year))")
                .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Theme.get(id: themeId).buttonColor.backgroundColor))
                .padding(.horizontal, 10)
                .onTapGesture(perform: onDateTap)
            
            Button(action: goToNextMonth, label: {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(Theme.get(id: themeId).buttonColor.backgroundColor)
            })
            
            Spacer()
        }
    }
}
