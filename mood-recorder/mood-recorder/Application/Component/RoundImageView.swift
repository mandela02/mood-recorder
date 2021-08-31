//
//  RoundImageView.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

struct RoundImageView: View {
    let image: Image
    let backgroundColor: Color
    let padding: CGFloat
    
    init(image: Image, backgroundColor: Color, padding: CGFloat = 10) {
        self.image = image
        self.backgroundColor = backgroundColor
        self.padding = padding
    }
    
    var body: some View {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(padding)
                .background(backgroundColor, in: Circle())
    }
}
