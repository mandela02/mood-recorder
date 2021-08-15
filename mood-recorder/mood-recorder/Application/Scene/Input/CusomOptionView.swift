//
//  CusomOptionView.swift
//  CusomOptionView
//
//  Created by LanNTH on 15/08/2021.
//

import SwiftUI

class CustomOptionViewModel {
    struct CustomOptionState {
        var images: [[AppImage]] = []
        var currentPage = 0
        var numberOfPage = 0
        
        var outPutModels: [OptionModel] = []
    }

}

struct CusomOptionView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CusomOptionView_Previews: PreviewProvider {
    static var previews: some View {
        CusomOptionView()
    }
}
