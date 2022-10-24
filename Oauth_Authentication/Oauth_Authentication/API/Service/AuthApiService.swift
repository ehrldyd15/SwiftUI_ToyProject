//
//  AuthApiService.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/20.
//

import Foundation
import Alamofire
import Combine

// 인증 관련 api 호출
enum AuthApiService {
    // 회원가입
    static func register(name: String, email: String, password: String) -> AnyPublisher<UserData, AFError> {
        print("AuthApiService - register() is called")
        
        return ApiClient.shared.session
            .request(AuthRouter.register(name: name, email: email, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map { receivedValue in
                receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    // 로그인
    static func login(email: String, password: String) -> AnyPublisher<UserData, AFError> {
        print("AuthApiService - login() is called")
        
        return ApiClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map { receivedValue in
                receivedValue.user
            }.eraseToAnyPublisher()
    }
}
