//
//  ContentView.swift
//  CoordinatorTest
//
//  Created by Do Kiyong on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationView {
            AView()
        }
    }
}

#Preview {
    ContentView()
}

