//
//  OAuthCredential.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/24.
//

import Foundation
import Alamofire

struct OAuthCredential: AuthenticationCredential {
    
    let accessToken: String
    
    let refreshToken: String
    
    let expiration: Date
    
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
    
}
