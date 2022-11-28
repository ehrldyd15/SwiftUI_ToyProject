//
//  ContentView.swift
//  TextFieldValidation
//
//  Created by Do Kiyong on 2022/11/25.
//

import SwiftUI
import Combine

final class SignUpViewModel: ObservableObject {
  @Published var password = ""
}

private extension SignUpViewModel {
    
    var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        password
            .map { pass in
                return pass.count >= 3
            }
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("비밀번호 ", text: $username)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
