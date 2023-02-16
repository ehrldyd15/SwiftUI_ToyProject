//
//  Home.swift
//  MarvelAPI
//
//  Created by Do Kiyong on 2023/02/15.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    var body: some View {
        TabView {
            CaractersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
                // Environment Object를 세팅한다.
                // 따라서 character View에서 데이터에 접근이 가능
                .environmentObject(homeData)
            
            ComicsView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
                .environmentObject(homeData)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
