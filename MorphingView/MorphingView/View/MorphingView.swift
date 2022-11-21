//
//  MorphingView.swift
//  MorphingView
//
//  Created by Do Kiyong on 2022/11/17.
//

import SwiftUI

struct MorphingView: View {
    // MARK: View Properties
    @State var currentImage: CustomShape = .cloud
    @State var turnOffImageMorph: Bool = false
    @State var blurRadius: CGFloat = 0
    
    var body: some View {
        VStack {
            // MARK: Image Morph is Simple
            // Simply Mask the Canvas Shape as Image Mask
            GeometryReader { proxy in
                let size = proxy.size
                
                Image("iJustine")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -20, y: 40)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .overlay(content: {
                        Rectangle()
                            .fill(.white)
                            .opacity(turnOffImageMorph ? 1 : 0)
                    })
                    .mask {
                        // MARK: Morphing Shape With the Help of Canvas and Fillters
                        Canvas { context, size in
                            // MARK: Morphing Filters
                            context.addFilter(.alphaThreshold(min: 0.5))
                            // MARK: This Value Plays Major Role in the Morphing Animation
                            context.addFilter(.blur(radius: blurRadius))
                            
                            if let resolvedImage = context.resolveSymbol(id: 1) {
                                context.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)
                            }
                        } symbols: {
                            // MARK: Giving Images With ID
                            ResolvedImage(currentImage: $currentImage)
                                .tag(1)
                        }
                        
                        // MARK: Animations will not work in the Canvas
                        // 
                    }
            }
            .frame(height: 400)
            
            // MARK: Segmented Picker
            Picker("", selection: $currentImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            .padding(15)
            .padding(.top, -50)
            
            Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
                .fontWeight(.semibold)
                .padding(.horizontal, 15)
                .padding(.top, 10)
            
            Slider(value: $blurRadius, in: 0...40)
        }
        .offset(y: -50)
        .frame(maxHeight: .infinity, alignment: .top)
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
