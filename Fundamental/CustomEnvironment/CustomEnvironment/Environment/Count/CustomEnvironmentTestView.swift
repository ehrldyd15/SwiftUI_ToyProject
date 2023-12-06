//
//  CustomEnvironmentTestView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

struct CustomEnvironmentTestView: View {
    @State private var count: Int = 0
    
    var body: some View {
        VStack {
            CustomEnvironmentTestChildView()
            
            CustomEnvironmentTestChildView()
                .environment(\.customCounter, count)
            
            HStack {
                Button("+") {
                    count += 1
                }
                .buttonStyle(.borderedProminent)
                
                Button("-") {
                    count -= 1
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
        
}

#Preview {
    CustomEnvironmentTestView()
}
