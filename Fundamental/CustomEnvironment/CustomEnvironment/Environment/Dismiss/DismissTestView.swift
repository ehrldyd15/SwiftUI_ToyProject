//
//  DismissTestView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

struct DismissTestView: View {
    @State private var isShow: Bool = false
    
    var body: some View {
        Button("present child") {
            isShow.toggle()
        }
        .fullScreenCover(isPresented: $isShow, content: {
            DismissTestChildView()
        })
        
    }
}

struct DismissTestChildView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            
            Button("Dismiss button") {
                dismiss()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    DismissTestView()
}
