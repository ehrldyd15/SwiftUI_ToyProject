//
//  DocumentsDetailView.swift
//  Navigation
//
//  Created by Do Kiyong on 2022/10/28.
//

import SwiftUI

struct DocumentsDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var showDocumentsDetail: Bool
    
    var body: some View {
        VStack {
            Text("from documents detatls example")
            
            Button("Dismiss via Binding") {
                showDocumentsDetail.toggle()
            }
            
            Button("Dismiss via Environment Values") {
                handleDismiss()
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .navigationBarHidden(true)
    }
}

private extension DocumentsDetailView {
    func handleDismiss() {
        if #available(iOS 15, *) {
            dismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct DocumentsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsDetailView(showDocumentsDetail: .constant(true))
    }
}
