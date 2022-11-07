//
//  Home.swift
//  CoffeeAppAnimation
//
//  Created by Do Kiyong on 2022/11/07.
//

import SwiftUI

struct Home: View {
    // MARL: Gesture Properties
    @State var offsetY: CGFloat = 0
    @State var currentIndex: CGFloat = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            // MARK: Since Card Size is the Size of the Screen Width
            let cardSize = size.width * 1
            
            // MARK: Bottom Gradient Background
            LinearGradient(colors: [
                .clear,
                Color("Brown").opacity(0.2),
                Color("Brown").opacity(0.45),
                Color("Brown")
            ], startPoint: .top, endPoint: .bottom)
            .frame(height: 300)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            
            // MARK: Header View
            HeaderView()
            
            VStack(spacing: 0) {
                ForEach(coffee) { coffee in
                    CoffeView(coffee: coffee, size: size)
                }
            }
            .frame(width: size.width)
            .padding(.top, size.height - cardSize)
            .offset(y: offsetY)
            .offset(y: -currentIndex * cardSize)
        }
        .coordinateSpace(name: "SCROLL")
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onChanged({ value in
                    // Slowing Down The Gesture
                    offsetY = value.translation.height * 0.4
                }).onEnded({ value in
                    let translation = value.translation.height
                    
                    withAnimation(.easeInOut) {
                        if translation > 0 {
                            // 250 -> Update it for Own Usage
                            if currentIndex > 0 && translation > 250 {
                                currentIndex -= 1
                            }
                        } else {
                            if currentIndex < CGFloat(coffee.count - 1) && -translation > 250 {
                                currentIndex += 1
                            }
                        }

                        offsetY = .zero
                    }
                })
        )
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title.bold())
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("Cart")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
            
            GeometryReader {
                let size = $0.size
                
                HStack(spacing: 0) {
                    ForEach(coffee) { coffee in
                        VStack(spacing: 15) {
                            Text(coffee.title)
                                .font(.title.bold())
                                .multilineTextAlignment(.center)
                            
                            Text(coffee.price)
                                .font(.title)
                        }
                        .frame(width: size.width)
                    }
                }
                .offset(x: currentIndex * -size.width)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8), value: currentIndex)
            }
            .padding(.top, -5)
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
