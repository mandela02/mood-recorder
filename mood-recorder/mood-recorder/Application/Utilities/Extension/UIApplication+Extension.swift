//
//  UIApplication+Extension.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
