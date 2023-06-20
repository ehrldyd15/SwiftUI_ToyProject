//
//  View+Extension.swift
//  ElasticScroll
//
//  Created by Do Kiyong on 2023/06/19.
//

import SwiftUI

// CustomView Modifiers
extension View {
    // Enables Elastic Scroll
    // NOTE: Need to be added to Each Item View inside the ScrollView
    
    @ViewBuilder
    func elasticScroll(scrollRect: CGRect, screenSize: CGSize) -> some View {
        self
            .modifier(ElasticScrollHelper(scrollRect: scrollRect, screenSize: screenSize))
    }

}

// Private Helper For Elastic Scroll
fileprivate struct ElasticScrollHelper: ViewModifier {
    var scrollRect: CGRect
    var screenSize: CGSize
    // View Modifier Properties
    @State private var viewRect: CGRect = .zero
    
    func body(content: Content) -> some View {
        let progress = scrollRect.minY / scrollRect.maxY
        // If you need more Elastic Then adjust it's multiplier
        let elasticOffset = (progress * viewRect.minY) * 1.5
        // Bottom Progress and Bottom ElasticOffset
        // To Start from Zero, Simply remove 1 from the Progress
        let bottomProgress = max(1 - (scrollRect.maxY / screenSize.height), 0)
        // If you need more Elastic Then adjust it's multiplier
        let bottomElasticOffset = (viewRect.maxY * bottomProgress) * 1
        content
//            .overlay(content: {
//                Text("\(bottomProgress)")
//            })
            .offset(y: scrollRect.minY > 0 ? elasticOffset : 0)
            .offset(y: scrollRect.minY > 0 ? -(progress * scrollRect.minY) : 0)
            .offset(y: scrollRect.maxY < screenSize.height ? bottomElasticOffset : 0)
            .offsetExtractor(coordinateSpace: "SCROLLVIEW") {
                viewRect = $0
            }
    }
}

struct View_Extension_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
