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
}

extension UserListInteractor: UserListInteractorInput {
    func fetchUserList() {
        networkController?.fetchUserList()
    }
}

extension UserListInteractor: UserListControllerDelegate {
    func updateUsersList(users: [UserProfile]) {
        output?.updateUserList(users)
    }
    
    func updateServerError(error: Error) {
        handleError(error)
    }
}
