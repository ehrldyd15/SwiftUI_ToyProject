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
        ZStack {
            LazyVStack {
                coordinator.navigationLinkSection()
                Text("AView")
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
            
            VStack {
                Spacer()
                
                Toggle("로딩", isOn: $isLoading)
            }
            .padding()
            
            VStack {
                if isLoading {
                    MetLoadingView()
                        .onAppear(perform: {
                            delay()
                        })
                }
            }
        }

    }
    
    private func delay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
    
}
