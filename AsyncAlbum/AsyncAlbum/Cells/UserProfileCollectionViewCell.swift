//
//  UserProfileCollectionViewCell.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 04/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

class UserProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet private(set) weak var profileImageView: UIImageView?
    @IBOutlet private(set) weak var nameLabel: UILabel?
    @IBOutlet private(set) weak var bottomView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView?.layer.cornerRadius = 6
        bottomView?.layer.masksToBounds = true
    }
    
    func setupUserInformation(imagePath: String, userName: String) {
        if let imageURL = URL(string: imagePath) {  profileImageView?.imageFromServerURL(imageURL)
        }
        nameLabel?.text = userName
    }
}
