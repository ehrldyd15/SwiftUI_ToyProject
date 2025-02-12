//
//  ArrowShape.swift
//  Popovers
//
//  Created by Do Kiyong on 2/12/25.
//

import SwiftUI

public struct ArrowShape: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addLines([
            CGPoint(x: 0, y: rect.height),
            CGPoint(x: rect.width / 2, y: 0),
            CGPoint(x: rect.width, y: rect.height),
        ])
        
        return path
    }
}

struct ArrowShape_Preview: PreviewProvider {
    static var previews: some View {
        ArrowShape().stroke()
    }
}

