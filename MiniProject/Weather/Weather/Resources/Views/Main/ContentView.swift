//
//  ContentView.swift
//  Weather
//
//  Created by Do Kiyong on 2023/02/28.
//

import SwiftUI

// https://www.youtube.com/watch?v=b8sP7AS0CAY&t=71s
// 9:46
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
