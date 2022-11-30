//
//  BottomContent.swift
//  BottomSheetDrawer
//
//  Created by Do Kiyong on 2022/11/03.
//

import SwiftUI

struct BottomContent: View {
    var body: some View {
        VStack {
            HStack {
                Text("Favorites")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("See All")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                })
            }
            .padding(.top, 20)
            
            Divider()
                .background(Color.white)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 15) {
                    VStack(spacing: 8) {
                        Button(action: {}, label: {
                            Image(systemName: "house.fill")
                                .font(.title)
                                .frame(width: 65, height: 65)
                                .background(BlurView(style: .dark))
                                .clipShape(Circle())
                        })
                        
                        Text("Home")
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 8) {
                        Button(action: {}, label: {
                            Image(systemName: "briefcase.fill")
                                .font(.title)
                                .frame(width: 65, height: 65)
                                .background(BlurView(style: .dark))
                                .clipShape(Circle())
                        })
                        
                        Text("Work")
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 8) {
                        Button(action: {}, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .frame(width: 65, height: 65)
                                .background(BlurView(style: .dark))
                                .clipShape(Circle())
                        })
                        
                        Text("Add")
                            .foregroundColor(.white)
                    }
                }
            })
            .padding(.top)
            
            HStack {
                Text("Editor's Pick")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("See All")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                })
            }
            .padding(.top, 25)
            
            Divider()
                .background(Color.white)
            
            ForEach(1...6, id: \.self) { index in
                Image("p\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                    .cornerRadius(15)
                    .padding(.top)
            }
        }
    }
}
