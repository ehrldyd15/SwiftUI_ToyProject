//
//  ContentView.swift
//  AutoScrollingTab
//
//  Created by Do Kiyong on 2023/03/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
