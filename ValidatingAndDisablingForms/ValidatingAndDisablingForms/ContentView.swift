//
//  ContentView.swift
//  ValidatingAndDisablingForms
//
//  Created by Do Kiyong on 2022/11/28.
//

import SwiftUI

struct ContentView: View {
    @State private var userName = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("UserName", text: $userName)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account..")
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
