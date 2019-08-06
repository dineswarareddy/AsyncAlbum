//
//  UIImageView+UsersKit.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 05/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

private let imageCache = NSCache<NSString, UIImage>()
private let placeHolderImage = UIImage.init(named: "PlaceHolder")

public extension UIImageView {
    func imageFromServerURL(_ url: URL?) {
        self.image = nil
        guard let url = url else { return }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.image = placeHolderImage
            }
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: NSString(string: url.absoluteString))
                        self?.image = downloadedImage
                        return
                    }
                }
            }
        }).resume()
    }
}
