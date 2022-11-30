//
//  OAuthAuthenticator.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/24.
//

import Foundation
import Alamofire

class OAuthAuthenticator: Authenticator {
   
    // 헤더에 인증 추가
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
            // 헤더에 Authrization 키로 Bearer 토큰값
            urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        
            // 만약에 커스텀이면
//            urlRequest.headers.add(name: "ACCESS_TOKEN", value: credential.accessToken)
        }

    // 토큰 리프레시
    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        
        print("OAuthAuthenticator - refresh() called")
        // 여기서 토큰 재발행 api 태우면 됩니다.
        
        let request = session.request(AuthRouter.tokenRefresh)
        
        request.responseDecodable(of: TokenResponse.self){ result in
            switch result.result {
                
            case .success(let value):
                
                // 재발행 받은 토큰 저장
                UserDefaultsManager.shared.setTokens(accessToken: value.token.accessToken,
                                                     refreshToken: value.token.refreshToken)
                
                let expiration = Date(timeIntervalSinceNow: 60 * 60)
                
                // 새로운 크리덴셜
                let newCredential = OAuthCredential(accessToken: value.token.accessToken,
                                                    refreshToken: value.token.refreshToken,
                                                    expiration: expiration)
                completion(.success(newCredential))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        // Refresh the credential using the refresh token...then call completion with the new credential.
        //
        // The new credential will automatically be stored within the `AuthenticationInterceptor`. Future requests will
        // be authenticated using the `apply(_:to:)` method using the new credential.
    }

    // api 요청 완료
    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        
        print("OAuthAuthenticator - didRequest() called")
        
        // 401 코드가 떨어지면 리프레시 토큰으로 액세스 토큰을 재발행 하라고 요청
        switch response.statusCode {
            case 401: return true
            default: return false
        }
        
        // If authentication server CANNOT invalidate credentials, return `false`
//        return false

        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure. This is generally a 401 along with a custom
        // header value.
        // return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `true`
        return true

        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        // return urlRequest.headers["Authorization"] == bearerToken
    }
}
