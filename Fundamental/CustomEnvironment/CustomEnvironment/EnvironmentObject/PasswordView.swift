//
//  PasswordView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

struct PasswordView: View {
    // @EnvironmentObject는 무조건 값이 있다고 가정하기 때문에 옵셔널이 아니다.
    // 따라서 상위뷰에서 .environmentObject설정을 해주지 않은 상태에서 값에 접근을 하면 앱이 무조건 죽는다.
    @EnvironmentObject var flowObject: RootFlowObject
    
    @State private var pw: String = ""
    
    var body: some View {
        VStack {
            Text("회원가입")
            
            TextField("pw 입력", text: $pw)
            
            Button("다음") {
                flowObject.viewType = .home
            }
            .buttonStyle(.borderedProminent)
            .disabled(pw.isEmpty)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
    }
}

#Preview {
    PasswordView()
}
