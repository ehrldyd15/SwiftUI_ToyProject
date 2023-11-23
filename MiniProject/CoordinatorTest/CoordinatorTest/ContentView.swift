//
//  ContentView.swift
//  CoordinatorTest
//
//  Created by Do Kiyong on 11/20/23.
//

import SwiftUI
import LoadingView

struct ContentView: View {
    @State private var isLoading = false
    
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
//        NavigationView {
//            AView()
//        }
        ZStack {

            
            VStack {
                Spacer()
                
                Toggle("로딩", isOn: $isLoading)
            }
            .padding()
            
            VStack {
                if isLoading {
                    MetLoadingView()
                }
            }
        }
        
        
    }
    
}

#Preview {
    ContentView()
}

