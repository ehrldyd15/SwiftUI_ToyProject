//
//  MetrixRainView.swift
//  Metrix
//
//  Created by Do Kiyong on 2022/10/11.
//

import SwiftUI

struct MatrixRainView: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            HStack(spacing: 15) {
                ForEach(1...Int(size.width / 25), id: \.self) { _ in
                    MatrixRainCharacters(size: size)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MatrixRainCharacters: View {
    var size: CGSize
    // Mark: Animation Properties
    @State var startAnimation: Bool = false
    @State var random: Int = 0
    
    var body: some View {
        // Random Height
        let randomHeight: CGFloat = .random(in: (size.height / 2)...size.height)
        
        VStack {
            // Mark: Iterating String
            ForEach(0..<constant.count, id: \.self) { index in
                // Retriving Character at String
                let character = Array(constant)[getRandomIndex(index: index)]
                
                Text(String(character))
                    .font(.custom("Matrix Code NFI", size: 25))
                    .foregroundColor(Color("Green"))
            }
        }
        // Fade like Animation Using Mask
        .mask(alignment: .top) {
            Rectangle()
                .fill(
                    LinearGradient(colors: [
                        .clear,
                        .black.opacity(0.1),
                        .black.opacity(0.2),
                        .black.opacity(0.3),
                        .black.opacity(0.5),
                        .black.opacity(0.7),
                        .black
                    ], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: size.height / 2)
                // Animating
                // To look like its coming from top
                .offset(y: startAnimation ? size.height : -randomHeight)
        }
        .onAppear {
            // Moving slowly down with linear Animation
            // Endless loop without reversing
            withAnimation(.linear(duration: 10).delay(.random(in: 0...2)).repeatForever(autoreverses: false)) {
                startAnimation = true
            }
        }
        // Timer
        .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
            random = Int.random(in: 0..<constant.count)
        }
    }
    
    // Changing Characters randomly with the help of Timer
    func getRandomIndex(index: Int) -> Int {
        // To avoid index out bound range
        let max = constant.count - 1
        
        if (index + random) > max {
            if (index - random) < 0 {
             
                return index
            }
            
            return (index - random)
        } else {
            
            return (index + random)
        }
    }
}

struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Mark: Random Characters
let constant = "asdaskjalksjdlkasjlkjiqweji1ioj21jpaskdjjkj"

