//
//  Home.swift
//  BookAnimation
//
//  Created by Do Kiyong on 2022/10/26.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            HeaderView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View {
        HStack(spacing: 15) {
            Text("Bookio")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image(systemName: "books.vertical")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            Button {
                
            } label: {
                Image(systemName: "book.closed")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
