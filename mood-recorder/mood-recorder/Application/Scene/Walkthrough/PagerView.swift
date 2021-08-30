//
//  PagerView.swift
//  PagerView
//
//  Created by TriBQ on 8/29/21.
//

import SwiftUI

struct PagerView<Content: View>: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    var pageCount: Int
    var content: Content
    
    @GestureState private var translation: CGFloat = 0

    init(index: Binding<Int>,
         offset: Binding<CGFloat>,
         pageCount: Int,
         @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._index = index
        self._offset = offset
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.index) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring(), value: index)
            .animation(.interactiveSpring(), value: translation)
            .onChange(of: translation, perform: { newValue in
                self.offset = newValue + -geometry.size.width * CGFloat(self.index)
            })
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.index) - offset).rounded()
                    self.index = min(max(Int(newIndex), 0),
                                     self.pageCount - 1)
                }
            )
        }
    }
}
