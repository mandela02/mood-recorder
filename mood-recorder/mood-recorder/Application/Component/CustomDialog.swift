//
//  CustomDialog.swift
//  CustomDialog
//
//  Created by LanNTH on 14/08/2021.
//

import SwiftUI

struct CustomDialog<DialogContent: View>: ViewModifier {
    var isShowing: Bool
    
    let padding: CGFloat
    let dialogContent: DialogContent
    
    init(isShowing: Bool,
         padding: CGFloat,
         @ViewBuilder dialogContent: () -> DialogContent) {
        self.isShowing = isShowing
        self.padding = padding
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isShowing {
                    ZStack {
                        Color.black.opacity(0.6)
                            .ignoresSafeArea()
                        dialogContent
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white))
                            .padding(padding)
                    }
                }
            }
            .animation(.easeInOut, value: isShowing)
    }
}

extension View {
    func customDialog<DialogContent: View>(
        isShowing: Bool,
        padding: CGFloat = 40,
        @ViewBuilder dialogContent: @escaping () -> DialogContent) -> some View {
            self.modifier(CustomDialog(isShowing: isShowing,
                                       padding: padding,
                                       dialogContent: dialogContent))
        }
}
