//
//  UserListInteractor.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

final class UserListInteractor {
    private let output: UserListInteractorOutput?
    private let networkController: UserListNetworkController?
    private var userProfiles: [UserProfile] = []
    
    init(presenter: UserListInteractorOutput?, networkController: UserListNetworkController?) {
        self.output = presenter
        self.networkController = networkController
        self.networkController?.delegate = self
    }
    
    private func handleError(_ error: Error) {
        switch error {
        case let apiError as APIError where apiError == .noInternetConnection:
            output?.updateNetworkError()
        default:
            output?.updateServerError()
        }
    }
    
    private func processUserProfilesList(_ list: [UserProfile]) {
        userProfiles.append(contentsOf: list)
        getUserList(0)
    }
    
    private func getUserList(_ initialIndex: Int) {
        let paginationCount = UserListConfiguration.userListPaginationCount
        let numberOfITemsToFetch = userProfiles.count > initialIndex + paginationCount ? paginationCount : (userProfiles.count - initialIndex)
        if numberOfITemsToFetch > 0 {
            let userListToDisplay = Array(userProfiles[initialIndex..<initialIndex + numberOfITemsToFetch])
            output?.updateUserList(userListToDisplay)
        }
    }
}

extension UserListInteractor: UserListInteractorInput {
    func fetchUserList(startIndex: Int) {
        getUserList(startIndex)
    }
    
    func fetchUserListFromAPI() {
        networkController?.fetchUserList()
    }
}

extension UserListInteractor: UserListControllerDelegate {
    func updateUsersList(users: [UserProfile]) {
        processUserProfilesList(users)
    }
    
    func updateServerError(error: Error) {
        handleError(error)
    }
}
