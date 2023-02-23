//
//  Ticket.swift
//  MovieBooking
//
//  Created by Do Kiyong on 2023/02/23.
//

import SwiftUI

struct Ticket: View {
    @State var title = "Thor"
    @State var subtitle = "Love and Thunder"
    @State var top = "thor-top"
    @State var bottom = "thor-bottom"
    @Binding var height: CGFloat
    
    var gradient = [Color("cyan"), Color("cyan").opacity(0), Color("cyan").opacity(0)]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                Text(title)
                    .fontWeight(.bold)
                
                Text(subtitle)
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
            .frame(width: 250, height: 325, alignment: .top)
            .foregroundColor(.white)
            .background(
                Image(top)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .mask(
                Image(top)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(LinearGradient(colors: gradient, startPoint: .topTrailing, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 2))
            }
            .cornerRadius(40, corners: [.topLeft, .topRight])
            
            Spacer(minLength: height)
            
            VStack(spacing: 10) {
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [7]))
                    .frame(width: 200, height: 1)
                    .opacity(0.6)
                
                HStack(spacing: 20) {
                    HStack(spacing: 4) {
                        Text("Date:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("lightPurple"))
                        
                        Text("April 23")
                            .foregroundColor(.black)
                    }
                    
                    HStack(spacing: 4) {
                        Text("Time:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("lightPurple"))
                        
                        Text("6 p.m.")
                            .foregroundColor(.black)
                    }
                }
                
                HStack(spacing: 20) {
                    HStack(spacing: 4) {
                        Text("Row:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("lightPurple"))
                        
                        Text("2")
                            .foregroundColor(.black)
                    }
                    
                    HStack(spacing: 4) {
                        Text("Seats:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("lightPurple"))
                        
                        Text("9, 10.")
                            .foregroundColor(.black)
                    }
                }
                
                Image("code")
            }
            .frame(width: 250, height: 135, alignment: .top)
            .background(.ultraThinMaterial)
            .background(
                Image(bottom)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .mask(
                Image(bottom)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
        }
        .frame(height: 460)
        .font(.footnote)
        .shadow(radius: 10)
    }
}

struct Ticket_Previews: PreviewProvider {
    static var previews: some View {
        Ticket(height: .constant(0))
    }
}
