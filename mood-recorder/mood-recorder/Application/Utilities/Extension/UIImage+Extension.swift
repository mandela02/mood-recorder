//
//  UIImage+Extension.swift
//  UIImage+Extension
//
//  Created by LanNTH on 14/08/2021.
//

import Foundation
import UIKit

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let image = self
        
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
