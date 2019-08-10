//
//  StorageManager.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 10/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

class StorageManager {
    private init() { }
    static let shareInstance = StorageManager()
    private var storedSize: Int = 0
    
    func fetchImage(imageURL: String) -> UIImage? {
        let imageObject = imageCache.filter { $0.imageURL == imageURL }.first
        if let imageObject = imageObject {
            if let imageObjectIndex = imageCache.firstIndex(where: {$0.imageURL == imageObject.imageURL}) {
                imageCache.remove(at: imageObjectIndex)
            }
            if let image = imageObject.image, let imageURL = imageObject.imageURL {
                imageCache.append(CachedImage(image: image, imageURL: imageURL))
                return image
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func cacheImage(image: UIImage, imageURL: String) {
        let imageObject = imageCache.filter { $0.imageURL == imageURL }.first
        if !(imageObject != nil) {
            imageCache.append(CachedImage(image: image, imageURL: imageURL))
            let currentImageSize = ((image.jpegData(compressionQuality: 1)?.count ?? 0) / 1024)
            storedSize += currentImageSize
            if storedSize > UserListConfiguration.maxStorageCapacity {
                print("Limit reached max size")
                storedSize -= ((imageCache.last?.image?.jpegData(compressionQuality: 1)?.count ?? 0) / 1024)
                imageCache.removeLast()
            }
        }
    }
}
