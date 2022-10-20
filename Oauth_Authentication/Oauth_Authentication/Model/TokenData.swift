//
//  TokenData.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/20.
//

import Foundation

struct TokenData: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
