//
//  PagerView.swift
//  PagerView
//
//  Created by TriBQ on 8/29/21.
//

import SwiftUI

struct PagerView<Content: View & Identifiable>: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    var pages: [Content]
    
    private func drag(in size: CGSize) -> some Gesture {
        return DragGesture().onChanged({ value in
            self.offset = value.translation.width + -size.width * CGFloat(self.index)
        }).onEnded({ value in
            withAnimation(.linear(duration: 0.5)) {
                if -value.predictedEndTranslation.width > size.width / 2,
                    self.index < self.pages.endIndex - 1 {
                    self.index += 1
                }
                if value.predictedEndTranslation.width > size.width / 2,
                   self.index > 0 {
                    self.index -= 1
                }
                self.offset = -size.width * CGFloat(self.index)
            }
        })
    }
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.pages) { page in
                        page
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                    }
                }
                .clipped()
                .offset(x: self.offset)
            }
            .gesture(drag(in: geometry.size))
            .frame(width: geometry.size.width,
                   height: geometry.size.height,
                   alignment: .leading)
            .onChange(of: index, perform: { _ in
                withAnimation(.linear(duration: 0.5)) {
                    self.offset = -geometry.size.width * CGFloat(self.index)
                }
            })
        }
    }
}
