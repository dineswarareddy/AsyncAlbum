//
//  UserListFactory.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

enum UserListFactory {
    static func createAlbumListFactory(view: UserListPresenterOutput?) -> UserListPresenterInput {
        let networkController = UserListNetworkController()
        let presenter = UserListPresenter(view: view)
        let interactor = UserListInteractor(presenter: presenter, networkController: networkController)
        presenter.view = view
        presenter.interactor = interactor
        return presenter
    }
}
