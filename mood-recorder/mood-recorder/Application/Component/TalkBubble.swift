//
//  TalkBubble.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

struct TalkBubble: View {
    var backgroundColor: Color
    var buttonBackgroundColor: Color
    var textColor: Color
    var onButtonTap: (AppImage) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                backgroundColor
                VStack(spacing: 15) {
                    Text("How are your feeling today?")
                        .foregroundColor(textColor)
                    HStack(alignment: .center,
                           spacing: 10,
                           content: {
                            ForEach(AppImage.allCases, id: \.self) { appImage in
                                Button(action: {}, label: {
                                    RoundImageView(image: appImage.image,
                                                   backgroundColor: buttonBackgroundColor)
                                })
                                .buttonStyle(ResizeAnimationButtonStyle())
                            }
                           })
                }
                .padding()
            }
            .frame(height: 180)
            .cornerRadius(20)
            backgroundColor
                .frame(width: 30, height: 20, alignment: .center)
                .clipShape(Triangle())
        }
        .padding()
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))

        return path
    }
}

struct TalkBubble_Previews: PreviewProvider {
    static var previews: some View {
        TalkBubble(backgroundColor: .green,
                   buttonBackgroundColor: .white,
                   textColor: .white,
                   onButtonTap: { _ in })
    }
}
