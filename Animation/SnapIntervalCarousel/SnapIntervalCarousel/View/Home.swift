//
//  Home.swift
//  SnapIntervalCarousel
//
//  Created by Do Kiyong on 2023/08/28.
//

import SwiftUI

struct Home: View {
    // View Properties
    @State private var images: [ImageFile] = []
    
    var body: some View {
        // Header View
        VStack(spacing: 0) {
            Text("GALLERY")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding([.horizontal, .bottom], 15)
                .padding(.top, 10)
            
            GeometryReader {
                let size = $0.size
            }
            
            // Snap Interval Carousel
            GeometryReader {
                let size = $0.size
                let pageWidth: CGFloat = 100
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(images) { imageFile in
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                                .frame(width: pageWidth, height: size.height)
                        }
                    }
                }
            }
            .frame(height: 120)
        }
        .background {
            // Color Gradient BG
            Rectangle()
                .fill(Color("BG").opacity(0.6).gradient)
                .rotationEffect(.init(degrees: -180))
                .ignoresSafeArea()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
