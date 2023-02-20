//
//  ContentView.swift
//  Whats_In_New(16.4)
//
//  Created by Do Kiyong on 2023/02/20.
//

// ✅ SwiftUI에서는 항상 sheets 옵션에 대하여 커스텀을 했다.
// 다행스럽게도 16.4 부터는 이러한 옵션들을 사용할 수 있다.
import SwiftUI

struct ContentView: View {
    var body: some View {
//        SheetOptions()
//        ScrollViewOptions()
        PopoverOptions()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
