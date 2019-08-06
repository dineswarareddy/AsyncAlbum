//
//  UserListPresenterBoundaries.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

protocol UserListPresenterInput {
    func findAlbumList()
    func loadMoreContent(startIndex: Int)
}

protocol UserListPresenterOutput {
    func displayUsersList(_ users: [UserProfileViewModel])
    func displayError(_ errorMessage: String)
}
