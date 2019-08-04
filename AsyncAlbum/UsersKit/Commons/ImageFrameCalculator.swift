//
//  ImageFrameCalculator.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 04/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

class ImageSizeCalculator {
    func resizeImage(originalSize: CGSize, targetSize: CGSize) -> CGSize {
        
        let widthRatio  = targetSize.width  / originalSize.width
        let heightRatio = targetSize.height / originalSize.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: originalSize.width * heightRatio, height: originalSize.height * heightRatio)
        } else {
            newSize = CGSize(width: originalSize.width * widthRatio,  height: originalSize.height * widthRatio)
        }
        return newSize
    }
}
