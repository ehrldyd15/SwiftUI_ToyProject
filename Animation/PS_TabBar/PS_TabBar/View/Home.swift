//
//  Home.swift
//  PS_TabBar
//
//  Created by Do Kiyong on 2023/02/21.
//

import SwiftUI

struct Home: View {
    // Tab Bar Properties
    @State private var activeTab: Tab = .play
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // 커스텀 탭바
            CustomTabBar(activeTab: $activeTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(Color("BG"))
                .ignoresSafeArea()
        }
        // Hiding the home view indicator at the bottom
        .persistentSystemOverlays(.hidden)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
