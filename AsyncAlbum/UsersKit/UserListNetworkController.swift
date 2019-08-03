//
//  UserListNetworkController.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

protocol UserListControllerDelegate {
    func updateUsersList(users: [UserProfile])
    func updateServerError(error: Error)
}

final class UserListNetworkController {
    var delegate: UserListControllerDelegate?
    func fetchUserList() {
        if let userListURL = URL(string: AlbumListConfiguration.userListURL) {
            ServiceHandler.fetchUsersList(requestURL: userListURL) { [weak self] (userListData, error) -> (Void) in
                guard let error = error else {
                    let jsonData = try? JSONSerialization.data(withJSONObject:userListData)
                    if let response = jsonData {
                        self?.convertDataToUserList(response)
                    }
                    return
                }
                self?.delegate?.updateServerError(error: error)
            }
        }
    }
    
    private func convertDataToUserList(_ response: Data) {
        let decoder = JSONDecoder()
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let userList = try decoder.decode([UserProfile].self, from: response)
            delegate?.updateUsersList(users: userList)
        } catch {
            delegate?.updateServerError(error: DefinedError.serviceError)
        }
    }
}
