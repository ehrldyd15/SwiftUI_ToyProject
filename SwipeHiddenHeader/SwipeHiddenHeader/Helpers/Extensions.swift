//
//  Extensions.swift
//  SwipeHiddenHeader
//
//  Created by Do Kiyong on 2022/11/15.
//

import SwiftUI

// MARK: Custom View Extensions
// Offset Extensions
extension View {
    // MARK: Previous, Current Offset To Find the Direction Of Swipe
    @ViewBuilder
    func offsetY(completion: @escaping (CGFloat, CGFloat) -> ()) -> some View {
        self
            .modifier(OffsetHelper(onChange: completion))
    }
    
    // MARK: Safe Area
    func safeArea() -> UIEdgeInsets {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = scene.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
}

// MARK: Offset Helper
struct OffsetHelper: ViewModifier {
    @State var currentOffset: CGFloat = 0
    @State var previousOffset: CGFloat = 0
    
    var onChange: (CGFloat, CGFloat) -> ()
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            previousOffset = currentOffset
                            currentOffset = value
                            onChange(previousOffset, currentOffset)
                        }
//                        .onAppear {
//                            print(proxy.frame(in: .global))
//                            print(proxy.frame(in: .local))
//                            print(proxy.frame(in: .named("SCROLL")))
//                        }
                }
            }
    }

}

// MARK: Offset Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: Bounds Preference Key For Identifing Height of The Header View
struct HeaderBoundsKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>?
    
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}
