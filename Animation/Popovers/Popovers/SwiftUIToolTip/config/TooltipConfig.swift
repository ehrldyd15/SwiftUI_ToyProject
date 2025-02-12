//
//  TooltipConfig.swift
//  Popovers
//
//  Created by Do Kiyong on 2/12/25.
//

import SwiftUI

public enum ArrowType {
    case `default`, curveIn
}

public protocol TooltipConfig {
    // MARK: - Alignment
    var side: TooltipSide { get set }
    var margin: CGFloat { get set }
    var zIndex: Double { get set }
    
    // MARK: - Sizes
    var width: CGFloat? { get set }
    var height: CGFloat? { get set }

    // MARK: - Tooltip container
    var borderRadius: CGFloat { get set }
    var borderRadiusStyle: RoundedCornerStyle { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: Color { get set }
    var backgroundColor: Color { get set }
    var shadowColor: Color { get set }
    var shadowRadius: CGFloat { get set }
    var shadowOffset: CGPoint { get set }

    // MARK: - Margins and paddings
    var contentPaddingLeft: CGFloat { get set }
    var contentPaddingRight: CGFloat { get set }
    var contentPaddingTop: CGFloat { get set }
    var contentPaddingBottom: CGFloat { get set }

    var contentPaddingEdgeInsets: EdgeInsets { get }

    // MARK: - Tooltip arrow
    var showArrow: Bool { get set }
    var arrowWidth: CGFloat { get set }
    var arrowHeight: CGFloat { get set }
    var arrowType: ArrowType { get set }
    
    // MARK: - Animation settings
    var enableAnimation: Bool { get set }
    var animationOffset: CGFloat { get set }
    var animationTime: Double { get set }
    var animation: Optional<Animation> { get set }

    var transition: AnyTransition { get set }
}

