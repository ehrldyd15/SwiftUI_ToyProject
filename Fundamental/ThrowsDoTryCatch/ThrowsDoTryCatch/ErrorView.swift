//
//  ErrorView.swift
//  ThrowsDoTryCatch
//
//  Created by Do Kiyong on 12/12/23.
//

import SwiftUI

enum DisplayError: Error {
    case notDriveTime
    case noBusDriver
}

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
    let guidance: String
}

struct ErrorView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let errorWrapper: ErrorWrapper
    
    var body: some View {
        VStack(spacing: 30) {
            Button() {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.largeTitle)
            }
            
            Text("버스 디스플레이 오류")
                .font(.title)
                .padding(.bottom)
            
            Text(errorWrapper.error.localizedDescription)
                .font(.headline)
            
            Text(errorWrapper.guidance)
                .font(.body)
            
            Spacer()
        }
        .padding(.top)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

#Preview {
    ErrorView(errorWrapper: ErrorWrapper(error: DisplayError.noBusDriver, guidance: "버스가 출발할 수 없는 시간입니다."))
}
