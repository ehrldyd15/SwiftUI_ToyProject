//
//  BView.swift
//  CoordinatorTest
//
//  Created by Do Kiyong on 11/20/23.
//

import SwiftUI

struct BView: View {
    
    @StateObject var coordinator = Coordinator()
    
    let product: Product
    
    var body: some View {
        VStack {
            coordinator.navigationLinkSection()
            Text("BView \(product.name)")
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
