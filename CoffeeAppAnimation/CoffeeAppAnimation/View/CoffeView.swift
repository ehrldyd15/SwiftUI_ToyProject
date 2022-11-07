//
//  CoffeView.swift
//  CoffeeAppAnimation
//
//  Created by Do Kiyong on 2022/11/07.
//

import SwiftUI

struct CoffeView: View {
    var coffee: Coffee
    var size: CGSize
    
    var body: some View {
        // MARK: If you want to decrease the size of the image, then change it's Card size
        let cardSize = size.width * 1
        // Since I want to show three max card on the display
        // MARK: Since we used scaling to decrease the view size add extra one
        let maxCardsDisplaySize = size.width * 3
        
        GeometryReader { proxy in
            let _size = proxy.size
            
            // MARK: Scaling Animation
            // Current Card Offset
            let offset = proxy.frame(in: .named("SCROLL")).minY - (size.height - cardSize)
            let scale = offset <= 0 ? (offset / maxCardsDisplaySize) : 0
            let reducedScale = 1 + scale
            let currentCardScale = offset / cardSize
            
            Image(coffee.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: _size.width, height: _size.height)
                // To avoid warning
                // MARK: Updating anchor based on the current card scale
                .scaleEffect(reducedScale < 0 ? 0.001 : reducedScale, anchor: .init(x: 0.5, y: 1 - (currentCardScale / 2.4)))
                // MARK: When it's Coming from bottom Animating the Scale from Large the Actual
                .scaleEffect(offset > 0 ? 1 + currentCardScale : 1, anchor: .top)
                // MARK: To remove the excess next view using offset to move the view in real time
                .offset(y: offset > 0 ? currentCardScale * 200 : 0)
                // Making it More Compact
                .offset(y: currentCardScale * -130)
            

        }
        .frame(height: cardSize)
    }
}

