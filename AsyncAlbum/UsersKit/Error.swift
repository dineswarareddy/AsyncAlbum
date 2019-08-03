//
//  Error.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

public enum APIError: Error
{
    case unknown
    case badURL
    case unauthorized
    case forbidden
    case notFound
    case internalError
    case timeout
    case noInternetConnection
    case conflict
}
