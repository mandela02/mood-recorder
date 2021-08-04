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
    
    var body: some View {
        ZStack {
            backgroundColor
                .clipShape(Circle())
            image
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .clipShape(Circle())
        }
    }
}

struct RoundImageView_Previews: PreviewProvider {
    static var previews: some View {
        RoundImageView(image: CoreEmotion.blissful.image,
                       backgroundColor: .pink)
    }
}
