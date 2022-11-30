//
//  TokenResponse.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/24.
//

import Foundation
// MARK: - TokenResponse
struct TokenResponse: Codable {
    let message: String
    let token: TokenData
}

