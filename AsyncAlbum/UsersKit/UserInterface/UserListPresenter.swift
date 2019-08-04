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
    
    private func constructUsersList(_ usersList: [UserProfile]) {
        let users = usersList.map({
            return UserProfileViewModel(id: $0.id, imagePath: $0.user?.profileImage?.large, name: $0.user?.name, likes: $0.likes) })
        view?.displayUsersList(users)
    }
}

extension UserListPresenter: UserListPresenterInput {
    func findAlbumList() {
        interactor?.fetchUserList()
    }
    
    func loadMoreContent() {
        
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
        constructUsersList(users)
    }
}
