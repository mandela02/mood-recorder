//
//  SafeOptionModel.swift
//  SafeOptionModel
//
//  Created by TriBQ on 8/24/21.
//

import Foundation

struct SafeOptionModel {
    var isSelected: Bool
    var isVisible: Bool
    var name: String?
    var image: String?
    
    var wrappedName: String {
        return name ?? ""
    }

    var wrappedImage: String {
        return image ?? ""
    }
}
