//
//  ContentView.swift
//  CoordinatorTest
//
//  Created by Do Kiyong on 11/20/23.
//

import SwiftUI
import LoadingView

struct ContentView: View {
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
//        NavigationView {
//            AView()
//        }
        VStack {
            MetLoadingView()
        }
    }
}

#Preview {
    ContentView()
}

