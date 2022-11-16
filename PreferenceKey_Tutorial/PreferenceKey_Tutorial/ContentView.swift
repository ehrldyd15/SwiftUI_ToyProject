//
//  ContentView.swift
//  PreferenceKey_Tutorial
//
//  Created by Do Kiyong on 2022/11/16.
//

import SwiftUI

struct ContentView: View {
    @State private var width: CGFloat? = nil
    
    var body: some View {
        Text("Hellodd")
            .padding()
            .fixedSize()
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizeKey.self, value: proxy.size.width)
                }
            )
            .frame(width: self.width, height: self.width)
            .background(
                Circle()
                    .fill(Color.blue)
            )
            .onPreferenceChange(SizeKey.self) { value in
                print("value: ", value)
                self.width = value
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SizeKey: PreferenceKey {
  static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
    value = nextValue()
  }
}
