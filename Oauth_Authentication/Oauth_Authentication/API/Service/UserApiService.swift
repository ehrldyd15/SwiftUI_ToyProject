//
//  UserApiService.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/24.
//

import Foundation
import Alamofire
import Combine

// 사용자 관련 api 호출
// 현재 사용자 정보, 모든 사용자 가져오기
enum UserApiService {
    // 현재사용자 정보
    static func fetchCurrentUserInfo() -> AnyPublisher<UserData, AFError> {
        print("AuthApiService - fetchCurrentUserInfo() called")
        
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()

        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 60))
        
        // Create the interceptor
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.fetchCurrentUserInfo, interceptor: authInterceptor)
            .publishDecodable(type: UserInfoResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    // 모든 사용자 정보
    static func fetchUsers() -> AnyPublisher<[UserData], AFError> {
        print("AuthApiService - fetchCurrentUserInfo() called")
        
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        

        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 60))
        
        // Create the interceptor
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.fetchUsers, interceptor: authInterceptor)
            .publishDecodable(type: UserListResponse.self)
            .value()
            .map{ $0.data }.eraseToAnyPublisher()
    }
}

