//
//  ScrollOffsetModifier.swift
//  AutoScrollingTab
//
//  Created by Do Kiyong on 2023/03/20.
//

import SwiftUI

// Offset Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// Custom View Modifier Extension
extension View {
    @ViewBuilder
    func offsetX(completion: @escaping(CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
}
