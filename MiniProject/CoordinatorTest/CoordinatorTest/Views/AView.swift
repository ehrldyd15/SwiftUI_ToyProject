//
//  AView.swift
//  CoordinatorTest
//
//  Created by Do Kiyong on 11/20/23.
//

import SwiftUI
import LoadingView

struct AView: View {
    
    @State private var isLoading = false
    
    @StateObject var coordinator = Coordinator(isRoot: true)
    
    var body: some View {
        LazyVStack {
            coordinator.navigationLinkSection()
            ZStack {
                Text("AView")
                
                VStack {
                    Spacer()
                    
                    Toggle("로딩", isOn: $isLoading)
                }
                
                VStack {
                    if isLoading {
                        MetLoadingView()
                    }
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(destination: .aView)
                } label: {
                    Image(systemName: "a.square.fill")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(destination: .bView(.init(name: "")))
                } label: {
                    Image(systemName: "b.square.fill")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(destination: .cView)
                } label: {
                    Image(systemName: "c.square.fill")
                }
            }
        }
    }
    
}
