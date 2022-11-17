//
//  ContentView.swift
//  PreferenceKey_Tutorial
//
//  Created by Do Kiyong on 2022/11/16.
//

import SwiftUI

// 1. background는 루트 뷰로부터 크기를 제안받는다.
// 2. background는 그 크기를 Text에게 제안한다.
// 3. Text는 자신이 포함하는 내용만을 담을 수 있는 크기를 사용하기로 결정하고 이를 background에게 알린다.
// 4. background는 그 정보를 GeometryReader에게 알린다.

struct ContentView: View {
    @State private var width: CGFloat? = nil
    
    var body: some View {
        Text("Hellodd")
            .padding()
            .fixedSize()
             // fixedSize 변경자는 Text에만 존재하는 변경자로 아무리 문자열이 길어져도 1줄에 보여주도록 강제한다.
             // 이를 사용하면 위에서 보았던 이미지처럼 주어진 크기 안에서 문자열이 길어질 때 여러 줄과 함께
             // 말 줄임표로 보여주는 것이 아니라 영역을 벗어나더라도 문자열을 1줄에 보여줄 수 있다.
            .background(
                GeometryReader { proxy in
                    // Color도 View 프로토콜을 따른다.
                    // 그렇기 때문에 사용자는 볼 수 없는 Color.clear에 preference를 통해
                    // proxy.size.width를 전달하고 있다.
                    Color.clear
                        .preference(key: SizeKey.self, value: proxy.size.width)
                }
            )
        
            .frame(width: self.width, height: self.width)
            .background(
                Circle()
                    .fill(Color.blue)
            )
            // 상위 뷰(Text)에선 하위 뷰에서 전달한 정보를 onPreferenceChange를 통해 받을 수 있다.
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
