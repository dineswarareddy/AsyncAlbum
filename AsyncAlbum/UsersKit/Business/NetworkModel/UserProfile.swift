//
//  UserProfile.swift
//  AsyncAlbum
//
//  Created by Dinesh Reddy on 03/08/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import Foundation

public struct UserProfile: Decodable {
    var id: String
    var createdAt: String?
    var width: Int?
    var height: Int?
    var color: String?
    var likes: Int?
    var likedByUser: Bool?
    var user: User?
    var currentUserCollection: [UserCollection]?
    var urls: ImageURL?
    var categories: [Category]?
    var links: Link?
}

// MARK: User Properties
public struct User: Decodable {
    var id: String
    var username:String?
    var name: String?
    var profileImage: ProfileImage?
    var links: UserLinks?
}

public struct ProfileImage: Decodable {
    var small: String?
    var medium: String?
    var large: String?
}

public struct UserLinks: Decodable {
    var `self`: String?
    var html: String?
    var photos: String?
    var likes: String?
}

// MARK: Current User Collections
public struct UserCollection: Decodable {
    
}

// MARK: User Image URL's
public struct ImageURL: Decodable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
}

// MARK: User Category's
public struct Category: Decodable {
    var id: Int
    var title: String?
    var photoCount: Int?
    var links: CategoryLink?
}

public struct CategoryLink: Decodable {
    var `self`: String?
    var photos: String?
}

// MARK: User Links
public struct Link: Decodable {
    var `self`: String?
    var html: String?
    var download: String?
}
