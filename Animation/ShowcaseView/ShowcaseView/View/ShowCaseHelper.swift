//
//  ShowCaseHelper.swift
//  ShowcaseView
//
//  Created by Do Kiyong on 2023/05/31.
//

import SwiftUI

// Custom Show Case View Extension
extension View {
    @ViewBuilder
    func showCase(order: Int, title: String, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
        self
        // Storing it in Anchor Preference
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                let highlight = Highlight(anchor: anchor, title: title, cornerRadius: cornerRadius, style: style, scale: scale)
                
                return [order : highlight]
            }
    }
}

// ShowCase Root View Modifier
struct ShowCaseRoot: ViewModifier {
    var showHighlights: Bool
    var onFinished: () -> ()
    
    // View Properties
    @State private var highlightOrder: [Int] = []
    @State private var currentHighlight: Int = 0
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys)
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightOrder.indices.contains(currentHighlight) {
                    if let highlight = preferences[highlightOrder[currentHighlight]] {
                        
                    }
                }
            }
    }
    
    // Highlight View
    @ViewBuilder
    func HighlightView(_ highlight: Highlight) -> some View {
        
    }
}

// Anchor Key
fileprivate struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int : Highlight] = [:]
    
    static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight]) {
        value.merge(nextValue()) { $1 }
    }
}

struct ShowCaseHelper_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
