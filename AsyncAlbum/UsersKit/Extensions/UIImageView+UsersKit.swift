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
private var currentDownloadingTasks: [URLSessionDataTask]? = []

public extension UIImageView {
    func imageFromServerURL(_ url: URL?) {
        self.image = nil
        guard let url = url else { return }
        self.accessibilityIdentifier = url.absoluteString
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
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
                        self?.removeTaskFromTodoList(url.absoluteString)
                        return
                    }
                }
            }
        })
        currentDownloadingTasks?.append(task)
        task.resume()
    }
    
    private func removeTaskFromTodoList(_ taskImageULR: String) {
        let taskToRemove = currentDownloadingTasks?.filter({ $0.currentRequest?.url?.absoluteString == taskImageULR }).first
        if let taskToRemove = taskToRemove, let indexToDelete = currentDownloadingTasks?.firstIndex(of: taskToRemove) {
            currentDownloadingTasks?.remove(at: indexToDelete)
        }
    }
    
    func cancelImageLoading() {
        if let imageURLToCancel = self.accessibilityIdentifier {
            if let taskToCancel = currentDownloadingTasks?.filter({ $0.currentRequest?.url?.absoluteString == imageURLToCancel }).first {
                taskToCancel.cancel()
                removeTaskFromTodoList(imageURLToCancel)
            }
        }
    }
}
