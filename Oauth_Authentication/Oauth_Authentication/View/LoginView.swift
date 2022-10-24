//
//  LoginView.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/19.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State fileprivate var shouldShowAlert: Bool = false
    
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("로그인 정보"), content: {
                    TextField("이메일", text: $emailInput)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("비밀번호", text: $passwordInput)
                })
                
                Section {
                    Button(action: {
                        print("로그인 버튼 클릭")
                        userViewModel.login(email: emailInput, password: passwordInput)
                    }, label: {
                        Text("로그인 하기")
                    })
                }
            }
            .onReceive(userViewModel.loginSuccess, perform: {
                print("LoginView - loginSuccess() is called")
                shouldShowAlert = true
            })
            .alert("로그인이 완료되었습니다.", isPresented: $shouldShowAlert) {
                Button("확인", role: .cancel) {
                    self.dismiss()
                }
            }
        }
        .navigationTitle("로그인 하기")
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
