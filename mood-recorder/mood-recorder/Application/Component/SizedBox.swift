//
//  SizedBox.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI

struct SizedBox: View {
    var height: CGFloat = 0
    var width: CGFloat = 0
    
    var body: some View {
        return Color.clear
            .frame(width: width, height: height)
    }
}
