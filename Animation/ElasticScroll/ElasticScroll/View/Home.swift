//
//  Home.swift
//  ElasticScroll
//
//  Created by Do Kiyong on 2023/06/19.
//

import SwiftUI

struct Home: View {
    @State private var scrollRect: CGRect = .zero
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 18) {
                    ForEach(sampleMessages) {
                        MessageRow($0)
                            .elasticScroll(scrollRect: scrollRect, screenSize: size)
                    }
                }
                .padding(15)
                .offsetExtractor(coordinateSpace: "SCROLLVIEW", completion: {
                    scrollRect = $0
                })
            }
//            .background(.blue)
            .coordinateSpace(name: "SCROLLVIEW")
//            .overlay {
//                Text("\(scrollRect.minY)")
//            }
        }
    }
    
    // Message Row View
    @ViewBuilder
    func MessageRow(_ message: Message) -> some View {
        HStack(spacing: 15) {
            Image(message.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            // Online Status
                .overlay(alignment: .bottomTrailing) {
                    Circle()
                        .fill(.green.gradient)
                        .frame(width: 15, height: 15)
                        .shadow(color: .primary.opacity(0.1), radius: 5, x: 5, y: 5)
                        .opacity(message.online ? 1 : 0)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.name)
                    .font(.callout)
                    .fontWeight(.bold)
                
                Text(message.message)
                    .font(.caption)
                    .foregroundColor(message.read ? .gray : .black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
