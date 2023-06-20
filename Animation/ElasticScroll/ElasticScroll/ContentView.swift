//
//  ContentView.swift
//  ElasticScroll
//
//  Created by Do Kiyong on 2023/06/19.
//

import SwiftUI

// https://www.youtube.com/watch?v=Xjp1bIoSOHs&t=43s
// 6:04

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Messages")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
