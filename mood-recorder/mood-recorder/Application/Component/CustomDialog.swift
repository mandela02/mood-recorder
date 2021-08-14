//
//  CustomDialog.swift
//  CustomDialog
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

struct CustomDialog<DialogContent: View>: ViewModifier {
    @Binding var isShowing: Bool
    
    let padding: CGFloat
    let dialogContent: DialogContent
    
    init(isShowing: Binding<Bool>,
         padding: CGFloat,
         @ViewBuilder dialogContent: () -> DialogContent) {
        _isShowing = isShowing
        self.padding = padding
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                dialogContent
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white))
                    .padding(padding)
            }
            .opacity(isShowing ? 1 : 0)
        }
    }
}

extension View {
    func customDialog<DialogContent: View>(
        isShowing: Binding<Bool>,
        padding: CGFloat = 40,
        @ViewBuilder dialogContent: @escaping () -> DialogContent) -> some View {
            self.modifier(CustomDialog(isShowing: isShowing,
                                       padding: padding,
                                       dialogContent: dialogContent))
        }
}
