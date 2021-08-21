//
//  ImageShareView.swift
//  ImageShareView
//
//  Created by TriBQ on 8/21/21.
//

import SwiftUI

struct ImageShareView: View {
    let image: UIImage
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Button(action: {}) {
                    Text("Share this image")
                        .font(.system(size: 12))
                        .foregroundColor(Theme.current.buttonColor.textColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .cornerRadius(20)
                .background(Theme.current.buttonColor.backgroundColor)
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
        }
    }
}
