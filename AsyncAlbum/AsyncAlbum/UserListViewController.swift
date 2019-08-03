//
//  UserListViewController.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    var presenter: UserListPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupFactory()
    }
    
    private func setupFactory() {
        presenter = UserListFactory.createAlbumListFactory(view: self)
        presenter?.findAlbumList()
    }
}

extension UserListViewController: UserListPresenterOutput {
    func displayUsersList(_ users: [UserProfile]) {
        print(users)
    }
    
    func displayError(_ errorMessage: String) {
        print(errorMessage)
    }
}
