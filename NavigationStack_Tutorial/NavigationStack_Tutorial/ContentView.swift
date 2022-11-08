//
//  ContentView.swift
//  NavigationStack_Tutorial
//
//  Created by Do Kiyong on 2022/11/08.
//

import SwiftUI

enum NavigationType: String, Hashable {
    case dm = "DM VIEW"
    case camera = "CAMERA VIEW"
    case home = "HOME"
}

struct ContentView: View {
    // MARK: Creating Navigation Stack
    // where you can Push and Pop Views
    
    @State var mainStack: [NavigationType] = []
    
    var body: some View {
        NavigationStack(path: $mainStack) {
            // MARK: 탭뷰를 활용한 복잡한 구조
            
            TabView {
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                Text("Linked")
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                
                Text("Settings")
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                    }
            }
            .navigationTitle("Instagram")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // MARK: Simply Push New View
                        mainStack.append(.dm)
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.callout)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // MARK: Simply Push New View
                        mainStack.append(.camera)
                    } label: {
                        Image(systemName: "camera")
                            .font(.callout)
                    }
                }
            }
            // MARK: New API that can Push new based on DataType
            .navigationDestination(for: NavigationType.self) { value in
                // MARK: Push your views based on value
                switch value {
                case .camera:
                    VStack {
                        Text("Camera View")
                        
                        // Pop View is Simple
                        // Just Remove Last Or Which View you neen to remove from stack
                        Button("POP") {
                            mainStack.removeLast()
                        }
                        
                        Button("Go to DM View") {
                            mainStack.append(.dm)
                        }
                    }
                case .home:
                    Text("Home View")
                case .dm:
                    VStack {
                        Text("DM View")
                        
                        // Pop View is Simple
                        // Just Remove Last Or Which View you neen to remove from stack
                        Button("POP") {
                            mainStack.removeLast()
                        }
                        
                        // Simply Clear The Items on the Stack
                        Button("POP to root") {
                            mainStack.removeAll()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
