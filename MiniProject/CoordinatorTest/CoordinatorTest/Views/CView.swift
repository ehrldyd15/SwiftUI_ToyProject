//
//  CView.swift
//  CoordinatorTest
//
//  Created by Do Kiyong on 11/20/23.
//

import SwiftUI

struct CView: View {
    
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
        VStack {
            coordinator.navigationLinkSection()
            Text("CView")
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.popToRoot()
                } label: {
                    Image(systemName: "house")
                }
            }
        }
    }
    
}
