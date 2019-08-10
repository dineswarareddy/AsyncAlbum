//
//  ServiceHandler.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation
import Alamofire

enum DefinedError: String, Error {
    case urlFormatError = "Invalid URL Format"
    case serviceError = "Server issue"
}

class ServiceHandler: NSObject {
    private override init() { }
    static let shared = ServiceHandler()
    typealias ServiceCallBack = (_ response: Any?, _ error: Error?) -> (Void)
    static var cacheResponse: [String: Any]? = [:]
    static func fetchUsersList(requestURL: URL, useCache: Bool = false, parameters: [String: Any] = [:], completion: @escaping ServiceCallBack) {
        if useCache, let existingResponse = cacheResponse?[requestURL.absoluteString] {
                completion(existingResponse, nil)
                return
        }
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: parameters)
            .validate()
            .responseJSON { response in
                guard response.result.isFailure else {
                    cacheResponse?[requestURL.absoluteString] = response.result.value
                    completion(response.result.value, nil)
                    return
                }
                completion(nil, DefinedError.serviceError)
        }
    }
}
