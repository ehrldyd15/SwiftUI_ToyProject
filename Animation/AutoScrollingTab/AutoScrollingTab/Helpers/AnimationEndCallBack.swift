//
//  AnimationEndCallBack.swift
//  AutoScrollingTab
//
//  Created by Do Kiyong on 2023/03/21.
//

import SwiftUI

struct AnimationState {
    var progress: CGFloat = 0 // Animation이 끝나는 것을 Observing할 것이다.
    var status: Bool = false
    
    mutating func startAnimation() {
        progress = 1.0
        status = true
    }
    
    mutating func reset() {
        progress = .zero
        status = false
    }
}

struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {
    var animatableData: Value {
        didSet {
            checkIfAnimationFinished()
        }
    }
    
    var endValue: Value
    var onEnd: () -> ()
    
    init(endValue: Value, onEnd: @escaping () -> ()) {
        self.endValue = endValue
        self.animatableData = endValue
        self.onEnd = onEnd
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    func checkIfAnimationFinished() {
        if animatableData == endValue {
            DispatchQueue.main.async {
                onEnd()
            }
        }
    }
}
