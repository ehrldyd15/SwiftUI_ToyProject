//
//  ContentView.swift
//  MorphingView
//
//  Created by Do Kiyong on 2022/11/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MorphingView()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
