//
//  AuthResponse.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/20.
//

import Foundation

struct AuthResponse : Codable {
    var user: UserData
    var token: TokenData
    
    enum CodingKeys: String, CodingKey {
        case token
        case user
    }
}
