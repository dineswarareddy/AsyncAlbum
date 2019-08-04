//
//  UserListViewController.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

private enum CollectionViewConstants {
    static let userCellReuseIdentifier = "UserProfileCollectionViewCell"
    enum Padding {
        static let top: CGFloat = 20
        static let bottom: CGFloat = 10
        static let right: CGFloat = 10
        static let left: CGFloat = 10
    }
}

class UserListViewController: UICollectionViewController {
    var presenter: UserListPresenterInput?
    var userList: [UserProfileViewModel] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupFactory()
        setupUserListCollectionView()
    }
    
    private func setupUserListCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: CollectionViewConstants.Padding.top, left: CollectionViewConstants.Padding.left, bottom: CollectionViewConstants.Padding.bottom, right: CollectionViewConstants.Padding.right)
        if let layout = collectionView.collectionViewLayout as? UserCollectionViewLayout {
            layout.delegate = self
        }
    }
    
    private func setupFactory() {
        presenter = UserListFactory.createAlbumListFactory(view: self)
        presenter?.findAlbumList()
    }
}

extension UserListViewController: UserLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension UserListViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let userProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstants.userCellReuseIdentifier, for: indexPath) as? UserProfileCollectionViewCell else {
            return UICollectionViewCell()
        }
        let userProfile = userList[indexPath.item]
        if let imagePath = userProfile.imagePath, let userName = userProfile.name {
            userProfileCell.setupUserInformation(imagePath: imagePath, userName: userName)
        }
        return userProfileCell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height + 0.0001
        if endScrolling >= scrollView.contentSize.height {
            presenter?.loadMoreContent()
        }
    }
}

extension UserListViewController: UserListPresenterOutput {
    func displayUsersList(_ users: [UserProfileViewModel]) {
        userList.append(contentsOf: users)
    }
    
    func displayError(_ errorMessage: String) {
        print(errorMessage)
    }
}
