//
//  ScrollViewOptions.swift
//  Whats_In_New(16.4)
//
//  Created by Do Kiyong on 2023/02/20.
//

import SwiftUI

struct ScrollViewOptions: View {
    var body: some View {
        List(1...10, id: \.self) { index in
            Text("Row With Index: \(index)")
        }
//        .scrollBounceBehavior(.basedOnSize) // 리스트의 높이가 시트보다 높지 않으면 바운스를 없앤다.
//        .scrollBounceBehavior(.basedOnSize, axes: .vertical) // vertical, horizontal 바운스를 없애는 옵션
    }
}

struct ScrollViewOptions_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOptions()
    }
}
