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
                            if let thumbnail = imageFile.thumbnail {
                                Image(uiImage: thumbnail)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: pageWidth, height: size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                        }
                    }
                    // Making to Start from the Center
                    .padding(.horizontal, (size.width - pageWidth) / 2)
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
        .task {
            // Adding Images
            guard images.isEmpty else { return }
            
            for index in 1...10 {
                let imageName = "Pic \(index)"
                // Creating Thumbnail (Save Lots of Memory)
                if let thumbnail = await UIImage(named: imageName)?.byPreparingThumbnail(ofSize: CGSize(width: 300, height: 300)) {
                    images.append(.init(imageName: imageName, thumbnail: thumbnail))
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
