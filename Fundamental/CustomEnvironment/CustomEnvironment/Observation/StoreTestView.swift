//
//  StoreTestView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/7/23.
//

import SwiftUI

struct StoreTestView: View {
    @ObservedObject var store: Store = Store()
    
    var body: some View {
//        let _ = Self._printChanges()
        
        VStack {
            Text("ObservavledObject")
            
            Text(store.item.name)
            
            Button("name change") {
                store.item.name = "name changed!"
            }
        }
    }
}

#Preview {
    StoreTestView()
}
