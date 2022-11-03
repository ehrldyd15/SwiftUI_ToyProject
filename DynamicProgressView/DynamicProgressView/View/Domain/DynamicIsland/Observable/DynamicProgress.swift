//
//  DynamicProgress.swift
//  DynamicProgressView
//
//  Created by Do Kiyong on 2022/11/03.
//

import Foundation
import SwiftUI

// MARK: Custom Observable Object to Handle Updates
class DynamicProgress: NSObject, ObservableObject {
    // MARK: 추가, 업데이트, 제거 메소드
    func addProgressView(config: ProgressConfig) {
        let swiftUIView = DynamicProgressView(config: config)
            .environmentObject(self)
        let hostingView = UIHostingController(rootView: swiftUIView)
    }
    
    func updateProgressView(to: CGFloat) {
        
    }
    
    func removedProgressView() {
        
    }
}
