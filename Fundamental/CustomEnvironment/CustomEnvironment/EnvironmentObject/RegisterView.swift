//
//  RegisterView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var id: String = ""
    
    var body: some View {
        VStack {
            Text("회원가입 화면입니다")
            
            TextField("id 입력", text: $id)
            
            NavigationLink {
                PasswordView()
            } label: {
                Text("다음")
            }
            .disabled(id.isEmpty)

        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(.yellow)
    }
}

#Preview {
    RegisterView()
}
