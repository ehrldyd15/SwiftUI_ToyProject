//
//  CustomEnvironmentTestChildView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

struct CustomEnvironmentTestChildView: View {
    @Environment(\.customCounter) var counter
    
    var body: some View {
        Text("\(counter)")
    }
}

#Preview {
    CustomEnvironmentTestChildView()
}
