//
//  DynamicProgressView.swift
//  DynamicProgressView
//
//  Created by Do Kiyong on 2022/11/03.
//

import SwiftUI

struct DynamicProgressView: View {
    // MARK: Passing Properties
    var config: ProgressConfig
    
    @EnvironmentObject var progressBar: DynamicProgress
    
    // MARK: Animation Properties
    @State var showProgressView: Bool = false
    
    var body: some View {
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.5, color: .black))
            ctx.addFilter(.blur(radius: 5.5))
            
            ctx.drawLayer { context in
                for index in [1, 2] {
                    if let resolvedImage = ctx.resolveSymbol(id: index) {
                        // MARK: Dynamic Area Top Offset = 11
                        // Capsule Height = 37 / 2 -> 18
                        context.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: 11 + 18))
                    }
                }
            }
        } symbols: {
            ProgressComponents()
                .tag(1)
            ProgressComponents(isCircle: true)
                .tag(2)
        }
        .ignoresSafeArea()
        // Since It Will Be An Overlay On Root Controller
        // 루트뷰 밑에서 상호작용 할 수 있도록 탭 제스처 비활성화
        .allowsHitTesting(false)
    }
    
    // MARK: Progress Bar Components
    @ViewBuilder
    func ProgressComponents(isCircle: Bool = false) -> some View {
        if isCircle {
            Circle()
                .fill(.black)
                .frame(width: 37, height: 37)
                .frame(width: 126, alignment: .trailing)
                .offset(x: showProgressView ? 45 : 0)
                .scaleEffect(showProgressView ? 1 : 0.55, anchor: .trailing)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: showProgressView)
        } else {
            // MARK: Dynamic Island Size = (126, 37)
            Capsule()
                .fill(.black)
                .frame(width: 126, height: 37)
        }
    }
}

