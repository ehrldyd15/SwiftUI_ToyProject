//
//  Destination.swift
//  CoordinatorTest
//
//  Created by Do Kiyong on 11/20/23.
//

import SwiftUI

enum Destination {
    case aView
    case bView(Product)
    case cView
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .aView:
            AView()
        case .bView(let product):
            BView(product: product)
        case .cView:
            CView()
        }
    }
}
