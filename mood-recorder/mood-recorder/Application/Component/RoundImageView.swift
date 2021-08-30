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
                .padding(padding)
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(backgroundColor, in: Circle())
    }
}

struct RoundImageView_Previews: PreviewProvider {
    static var previews: some View {
        RoundImageView(image: CoreEmotion.blissful.image,
                       backgroundColor: .pink)
    }
}
