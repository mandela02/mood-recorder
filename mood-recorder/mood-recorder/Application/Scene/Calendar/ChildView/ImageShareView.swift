//
//  ImageShareView.swift
//  ImageShareView
//
//  Created by TriBQ on 8/21/21.
//

import SwiftUI

struct ImageShareView: View {
    let image: UIImage
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Button(action: {}, label: {
                    Text("Share this image")
                        .font(.system(size: 12))
                        .foregroundColor(Theme.get(id: themeId).buttonColor.textColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                })
                .cornerRadius(20)
                .background(Theme.get(id: themeId).buttonColor.backgroundColor)
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
        }
    }
}
