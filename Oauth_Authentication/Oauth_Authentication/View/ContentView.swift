//
//  ContentView.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 160))
                
                Spacer()
                
                NavigationLink(destination: LoginView(),
                               label: {
                    HStack {
                        Spacer()
                        Text("로그인 하러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                .padding([.bottom], 10)
                
                NavigationLink(destination: RegisterView(),
                               label: {
                    HStack {
                        Spacer()
                        Text("회원가입 하러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                
                Spacer().frame(height: 40)
                
                NavigationLink(destination: ProfileView(),
                               label: {
                    HStack {
                        Spacer()
                        Text("내 프로필 보러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                .padding([.bottom], 10)
                
                NavigationLink(destination: UserListView(),
                               label: {
                    HStack {
                        Spacer()
                        Text("사용자 목록 보러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.green )
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                
                Spacer()
                Spacer()
            } 
            .padding()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
