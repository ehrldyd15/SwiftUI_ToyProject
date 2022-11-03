//
//  Home.swift
//  DynamicProgressView
//
//  Created by Do Kiyong on 2022/11/03.
//

import SwiftUI

struct Home: View {
    @StateObject var progressBar: DynamicProgress = .init()
    
    var body: some View {
        Button("Start Download") {

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 100)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
