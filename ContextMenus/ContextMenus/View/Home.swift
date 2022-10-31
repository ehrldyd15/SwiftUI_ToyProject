//
//  Home.swift
//  ContextMenus
//
//  Created by Do Kiyong on 2022/10/31.
//

import SwiftUI

struct Home: View {
    @State var expand = false
    @State var munus: [MenuList] = [
        .init(munu: "정보 공유"),
        .init(munu: "정보 공유1"),
        .init(munu: "정보 공유2"),
        .init(munu: "정보 공유3")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Capsule()
                    .foregroundColor(Color.gray)
                    .frame(height: 50)
                    
                Button(action: {
                    self.expand.toggle()
                }, label: {
                    Capsule()
                        .foregroundColor(Color.gray)
                        .frame(width: 50, height: 50)
                })
            }
            .padding(.horizontal, 20)
            
            if expand {
                DropDownView(expand: $expand, munus: $munus, popupWidth: 150, horizontalPadding: 20, leftRightMode: .right)
            }

            Spacer()
        }
        .padding(.top, 30)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
