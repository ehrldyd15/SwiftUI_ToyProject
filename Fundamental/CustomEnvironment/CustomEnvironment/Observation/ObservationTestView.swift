//
//  ObservationTestView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/7/23.
//

import SwiftUI

struct ObservationTestView: View {
    @State private var ostore = OStore()
    
    var body: some View {
        let _ = Self._printChanges()
        
        VStack {
            Text("observation")
            
            Text(ostore.item.name)
            
            Button("name change") {
                ostore.item.name = "name changed!"
            }
        }
    }
    
}

#Preview {
    ObservationTestView()
}
