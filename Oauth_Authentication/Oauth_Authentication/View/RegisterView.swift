//
//  RegisterView.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/19.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var nameInput: String = ""
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    
    var body: some View {
        VStack {
            Form {
                // 이름
                Section(header: Text("이름"), content: {
                    TextField("이름", text: $nameInput)
                        .keyboardType(.default)
                })
                
                // 이메일
                Section(header: Text("이메일"), content: {
                    TextField("이메일", text: $emailInput)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                })
                
                // 비밀번호
                Section(header: Text("로그인 정보"), content: {
                    SecureField("비밀번호", text: $passwordInput)
                        .keyboardType(.default)
                    SecureField("비밀번호 확인", text: $passwordInput)
                        .keyboardType(.default)
                })
                
                Section {
                    Button(action: {
                        print("회원가입 버튼 클릭")
                        userViewModel.register(name: nameInput, email: emailInput, password: passwordInput)
                    }, label: {
                        Text("회원가입 하기")
                    })
                }
            }
            .onReceive(userViewModel.registrationSuccess, perform: {
                print("RegisterView - registrationSuccess() is called")
                self.dismiss()
            })
        }
        .navigationTitle("회원가입")
    }
}
