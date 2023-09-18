//
//  ContentView.swift
//  SnapIntervalCarousel
//
//  Created by Do Kiyong on 2023/08/21.
//

import SwiftUI

// https://www.youtube.com/watch?v=ZiDVbDlHDF0&t=28s
// 4:54

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
