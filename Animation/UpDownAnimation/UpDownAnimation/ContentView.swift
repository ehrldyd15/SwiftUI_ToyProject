//
//  ContentView.swift
//  UpDownAnimation
//
//  Created by Do Kiyong on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var bouncing = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.red)
                .frame(height: 2)
                .frame(maxHeight: .infinity, alignment: bouncing ? .bottom : .top)
                .animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: bouncing)
                .onAppear {
                    self.bouncing.toggle()
                }
        }
        .frame(width: 200, height: 200)
        .background(Color.yellow)
    }
}

#Preview {
    ContentView()
}
