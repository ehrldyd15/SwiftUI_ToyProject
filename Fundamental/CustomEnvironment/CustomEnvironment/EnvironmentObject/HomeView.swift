//
//  HomeView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/7/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var flowOnject: RootFlowObject
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                Text("환영합니다! 홈화면!")
                
                Button("로그아웃") {
                    flowOnject.viewType = .register
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
}
