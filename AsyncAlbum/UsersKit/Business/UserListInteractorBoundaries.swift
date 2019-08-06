//
//  UserListInteractorBoundaries.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

protocol UserListInteractorInput {
    func fetchUserList(startIndex: Int)
    func fetchUserListFromAPI()
}

protocol UserListInteractorOutput {
    func updateUserList(_ users: [UserProfile])
    func updateNetworkError()
    func updateServerError()
}
