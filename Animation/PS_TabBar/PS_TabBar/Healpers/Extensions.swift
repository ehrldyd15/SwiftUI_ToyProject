//
//  Extensions.swift
//  PS_TabBar
//
//  Created by Do Kiyong on 2023/02/21.
//

import SwiftUI

// View Extensions
extension View {
    
    var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
}

extension View {
    func glow(_ color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
    }
}
