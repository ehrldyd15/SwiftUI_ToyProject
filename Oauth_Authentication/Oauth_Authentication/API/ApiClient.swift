//
//  ApiClient.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/20.
//

import Foundation
import Alamofire

// 다른데서 상속을 못받도록 final class로 정의
// api 호출 클라이언트 (BASE_URL마다 클라이언트를 각각 만들어주는게 좋다고 함)
final class ApiClient {
    
    static let shared = ApiClient()
    
    static let BASE_URL = "https://dev-jeongdaeri-oauth.tk/api"
    
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor() // application/json
    ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
    
}
