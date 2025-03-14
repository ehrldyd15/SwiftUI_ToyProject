//
//  TooltipModifier.swift
//  Popovers
//
//  Created by Do Kiyong on 2/12/25.
//

import SwiftUI

struct TooltipModifier<TooltipContent: View>: ViewModifier {
    // MARK: - Uninitialised properties
    var enabled: Bool
    var config: TooltipConfig
    var content: TooltipContent

    // MARK: - Initialisers
    init(enabled: Bool, config: TooltipConfig, @ViewBuilder content: @escaping () -> TooltipContent) {
        self.enabled = enabled
        self.config = config
        self.content = content()
    }

    // MARK: - Local state
    @State private var contentWidth: CGFloat = 10
    @State private var contentHeight: CGFloat = 10
    @State var animationOffset: CGFloat = 0
    @State var animation: Optional<Animation> = nil

    // MARK: - Computed properties
    var showArrow: Bool { config.showArrow && config.side.shouldShowArrow() }
    var actualArrowHeight: CGFloat { self.showArrow ? config.arrowHeight : 0 }

    var arrowOffsetX: CGFloat {
        switch config.side {
        case .bottom, .center, .top:
            return 0
        case .left:
            return (contentWidth / 2 + config.arrowHeight / 2)
        case .topLeft, .bottomLeft:
            return (contentWidth / 2
                + config.arrowHeight / 2
                - config.borderRadius / 2
                - config.borderWidth / 2)
        case .right:
            return -(contentWidth / 2 + config.arrowHeight / 2)
        case .topRight, .bottomRight:
            return -(contentWidth / 2
                + config.arrowHeight / 2
                - config.borderRadius / 2
                - config.borderWidth / 2)
        }
    }

    var arrowOffsetY: CGFloat {
        switch config.side {
        case .left, .center, .right:
            return 0
        case .top:
            return (contentHeight / 2 + config.arrowHeight / 2)
        case .topRight, .topLeft:
            return (contentHeight / 2
                + config.arrowHeight / 2
                - config.borderRadius / 2
                - config.borderWidth / 2)
        case .bottom:
            return -(contentHeight / 2 + config.arrowHeight / 2)
        case .bottomLeft, .bottomRight:
            return -(contentHeight / 2
                + config.arrowHeight / 2
                - config.borderRadius / 2
                - config.borderWidth / 2)
        }
    }

    // MARK: - Helper functions
    private func offsetHorizontal(_ g: GeometryProxy) -> CGFloat {
        switch config.side {
        case .left, .topLeft, .bottomLeft:
            return -(contentWidth + config.margin + actualArrowHeight + animationOffset)
        case .right, .topRight, .bottomRight:
            return g.size.width + config.margin + actualArrowHeight + animationOffset
        case .top, .center, .bottom:
            return (g.size.width - contentWidth) / 2
        }
    }

    private func offsetVertical(_ g: GeometryProxy) -> CGFloat {
        switch config.side {
        case .top, .topRight, .topLeft:
            return -(contentHeight + config.margin + actualArrowHeight + animationOffset)
        case .bottom, .bottomLeft, .bottomRight:
            return g.size.height + config.margin + actualArrowHeight + animationOffset
        case .left, .center, .right:
            return (g.size.height - contentHeight) / 2
        }
    }
    
    // MARK: - Animation stuff
    private func dispatchAnimation() {
        if (config.enableAnimation) {
            DispatchQueue.main.asyncAfter(deadline: .now() + config.animationTime) {
                self.animationOffset = config.animationOffset
                self.animation = config.animation
                DispatchQueue.main.asyncAfter(deadline: .now() + config.animationTime*0.1) {
                    self.animationOffset = 0
                    
                    self.dispatchAnimation()
                }
            }
        }
    }

    // MARK: - TooltipModifier Body Properties
    private var sizeMeasurer: some View {
        GeometryReader { g in
            Text("")
                .onAppear {
                    self.contentWidth = config.width ?? g.size.width
                    self.contentHeight = config.height ?? g.size.height
                }
        }
    }

    private var arrowView: some View {
        guard let arrowAngle = config.side.getArrowAngleRadians() else {
            return AnyView(EmptyView())
        }
        
        return AnyView(arrowShape(angle: arrowAngle, borderColor: config.borderColor)
            .background(arrowShape(angle: arrowAngle)
                .frame(width: config.arrowWidth, height: config.arrowHeight)
                .foregroundColor(config.backgroundColor)
            ).frame(width: config.arrowWidth, height: config.arrowHeight)
            .offset(x: CGFloat(Int(self.arrowOffsetX)), y: CGFloat(Int(self.arrowOffsetY))))
    }

    private func arrowShape(angle: Double, borderColor: Color? = nil) -> AnyView {
        switch config.arrowType {
        case .default:
            let shape = ArrowShape()
                .rotation(Angle(radians: angle))
            if let borderColor {
//                return AnyView(shape.stroke(borderColor))
                return AnyView(shape.stroke(borderColor, lineWidth: config.borderWidth))
            }
            return AnyView(shape)
        case .curveIn:
            let shape = CurveInArrowShape()
                .rotation(Angle(radians: angle))
            if let borderColor {
//                return AnyView(shape.stroke(borderColor))
                return AnyView(shape.stroke(borderColor, lineWidth: config.borderWidth))
            }
            return AnyView(shape)
        }
    }

    private var arrowCutoutMask: some View {
        guard let arrowAngle = config.side.getArrowAngleRadians() else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            ZStack {
                Rectangle()
                    .frame(
                        width: self.contentWidth + config.borderWidth * 2,
                        height: self.contentHeight + config.borderWidth * 2)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(
                        width: config.arrowWidth,
                        height: config.arrowHeight + config.borderWidth)
                    .rotationEffect(Angle(radians: arrowAngle))
                    .offset(
                        x: self.arrowOffsetX,
                        y: self.arrowOffsetY)
                    .foregroundColor(.black)
            }
            .compositingGroup()
            .luminanceToAlpha()
        )
    }

    var tooltipBody: some View {
        GeometryReader { g in
            ZStack {
                RoundedRectangle(cornerRadius: config.borderRadius, style: config.borderRadiusStyle)
//                    .stroke(config.borderWidth == 0 ? Color.clear : config.borderColor)
                    .stroke(config.borderWidth == 0 ? Color.clear : config.borderColor, lineWidth: config.borderWidth)
                    .frame(width: contentWidth, height: contentHeight)
                    .mask(self.arrowCutoutMask)
                    .background(
                        RoundedRectangle(cornerRadius: config.borderRadius)
                            .foregroundColor(config.backgroundColor)
                    )
                    .shadow(color: config.shadowColor,
                            radius: config.shadowRadius,
                            x: config.shadowOffset.x,
                            y: config.shadowOffset.y)
                
                ZStack {
                    content
                        .padding(config.contentPaddingEdgeInsets)
                        .frame(
                            width: config.width,
                            height: config.height
                        )
                        .fixedSize(horizontal: config.width == nil, vertical: true)
                }
                .background(self.sizeMeasurer)
                .overlay(self.arrowView)
            }
            .offset(x: self.offsetHorizontal(g), y: self.offsetVertical(g))
            .animation(self.animation)
            .zIndex(config.zIndex)
            .onAppear {
                self.dispatchAnimation()
            }
        }
    }

    // MARK: - ViewModifier properties
    func body(content: Content) -> some View {
        content
            .overlay(enabled ? tooltipBody.transition(config.transition) : nil)
    }
}

