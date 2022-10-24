//
//  UserViewModel.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/20.
//

import Foundation
import Alamofire
import Combine

// publisher 변경을 감지하기 위해서 ObservableObject 사용
class UserViewModel: ObservableObject {
    
    var subscription = Set<AnyCancellable>()
    
    @Published var loggedInUser: UserData? = nil
    
    // 회원가입 완료 이벤트
    var registrationSuccess = PassthroughSubject<(), Never>()
    
    // 로그인 완료 이벤트
    var loginSuccess = PassthroughSubject<(), Never>()
    
    // 회원가입 하기
    func register(name: String, email: String, password: String) {
        print("UserViewModel: register() is called")
        
        AuthApiService.register(name: name, email: email, password: password)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserViewModel Completion: \(completion)")
            } receiveValue: { (receivedUser: UserData) in
                self.loggedInUser = receivedUser
                self.registrationSuccess.send()
            }.store(in: &subscription)
    }
    
    // 로그인 하기
    func login(email: String, password: String) {
        print("UserViewModel: login() is called")
        
        AuthApiService.login(email: email, password: password)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserViewModel Completion: \(completion)")
            } receiveValue: { (receivedUser: UserData) in
                self.loggedInUser = receivedUser
                self.loginSuccess.send()
            }.store(in: &subscription)
    }
    
}
