//
//  UserListPresenter.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

private enum ErrorMessage {
    static let network = "Please check network connection"
    static let server = "Server failed to respond, Please try after sometime"
}

final class UserListPresenter {
    var interactor: UserListInteractorInput?
    var view: UserListPresenterOutput?
    
    init(view: UserListPresenterOutput?) {
        self.view = view
    }
}

extension UserListPresenter: UserListPresenterInput {
    func findAlbumList() {
        interactor?.fetchUserList()
    }
}

extension UserListPresenter: UserListInteractorOutput {
    func updateNetworkError() {
        view?.displayError(ErrorMessage.network)
    }
    
    func updateServerError() {
        view?.displayError(ErrorMessage.server)
    }
    
    func updateUserList(_ users: [UserProfile]) {
        view?.displayUsersList(users)
    }
}
