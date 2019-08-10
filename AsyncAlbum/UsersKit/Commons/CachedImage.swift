//
//  CachedImage.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 10/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

struct CachedImage {
    let image: UIImage?
    let imageURL: String?
    init(image: UIImage, imageURL: String) {
        self.image = image
        self.imageURL = imageURL
    }
}
