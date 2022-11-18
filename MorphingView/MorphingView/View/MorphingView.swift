//
//  MorphingView.swift
//  MorphingView
//
//  Created by Do Kiyong on 2022/11/17.
//

import SwiftUI

struct MorphingView: View {
    @State var currentImage: CustomShape = .cloud
    
    var body: some View {
        VStack {
            // MARK: Morphing Shape With the Help of Canvas and Fillters
            Canvas { context, size in
                if let resolvedImage = context.resolveSymbol(id: 1) {
                    context.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)

                }
            } symbols: {
                // MARK: Giving Images With ID
                ResolvedImage(currentImage: $currentImage)
                    .tag(1)
            }
            
            // MARK: Segmented Picker
            Picker("", selection: $currentImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            .padding(15)
        }
    }
}

struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 200))
            .frame(width: 300, height: 300)
    }
}

struct MorphingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
