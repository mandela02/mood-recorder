//
//  ImageAndTitleModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

struct ImageAndTitleModel: Equatable, Identifiable {
    var id = UUID()
    
    let image: AppImage
    let title: String
}
