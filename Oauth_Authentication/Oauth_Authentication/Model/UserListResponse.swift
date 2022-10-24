//
//  UserListResponse.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/24.
//

import Foundation
// MARK: - UserListResponse
struct UserListResponse: Codable {
    let data: [UserData]
}
