//
//  ImageAndTitleModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

struct ImageAndTitleModel: Equatable, Identifiable, Hashable {
    static func == (lhs: ImageAndTitleModel, rhs: ImageAndTitleModel) -> Bool {
        lhs.image == rhs.image && lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
        hasher.combine(title)
    }

    var id = UUID()
    
    let image: AppImage
    let title: String
}
