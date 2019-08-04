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
    typealias ServiceCallBack = (_ response: Any?, _ error: Error?) -> (Void)
    
    class func fetchUsersList(requestURL: URL, parameters: [String: Any] = [:], completion: @escaping ServiceCallBack) {
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: parameters)
            .validate()
            .responseJSON { response in
                guard response.result.isFailure else {
                    completion(response.result.value, nil)
                    return
                }
                completion(nil, DefinedError.serviceError)
        }
    }
}
