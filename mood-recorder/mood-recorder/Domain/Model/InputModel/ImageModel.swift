//
//  ImageModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI

class ImageModel {
    init(data: Data? = nil) {
        self.data = data
    }
    
    var data: Data?
    
    var image: Image {
        guard let data = data,
              let uiImage = UIImage(data: data) else {
            return Image(systemName: "plus")
        }
        
        return Image(uiImage: uiImage)
    }
    
    var imageSize: CGSize? {
        guard let data = data else {
            return nil
        }
        
        return UIImage(data: data)?.size
    }
    
    var aspectRatio: CGFloat {
        guard let size = imageSize else { return 1 }
        return size.width / size.height
    }
}
