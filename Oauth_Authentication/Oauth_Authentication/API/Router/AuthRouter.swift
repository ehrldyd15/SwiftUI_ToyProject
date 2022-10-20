//
//  AuthRouter.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/20.
//

import Foundation
import Alamofire

// 인증 라우터
// 회원가입, 로그인, 토큰갱신
enum AuthRouter: URLRequestConvertible {
    case register(name: String, email: String, password: String)
    case login(email: String, password: String)
    case tokenRefresh
    
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case.register:
            return "user/register"
        case .login:
            return "user/login"
        case .tokenRefresh:
            return "user/token-refresh"
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .register(let name, let email, let password):
            var params = Parameters()
            
            params["password"] = password
            params["email"] = email
            params["name"] = name
            
            return params
        case .login(let email, let password):
            var params = Parameters()
            
            params["email"] = email
            params["password"] = password
            
            return params
        case .tokenRefresh:
            var params = Parameters()
            
//            params["refreshTokem"] = "
            
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        
        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        
        return request
    }
}
