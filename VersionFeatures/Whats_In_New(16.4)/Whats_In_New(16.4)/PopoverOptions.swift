//
//  PopoverOptions.swift
//  Whats_In_New(16.4)
//
//  Created by Do Kiyong on 2023/02/20.
//

import SwiftUI

struct PopoverOptions: View {
    @State private var showPopover: Bool = false
    
    var body: some View {
        Button("Show Popover") {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover) {
            Image(systemName: "suit.heart.fill")
                .foregroundColor(.red)
                .padding(15)
            // SwiftUI IOS에서는 popover가 디폴트였다
            // 하지만 16.4 부터는 아래 Modifier를 통하여 변경 할 수 있다.
//                .presentationCompactAdaptation(.none) // .none은 IOS에서 popover 되도록 한다.
        }
    }
}

struct PopoverOptions_Previews: PreviewProvider {
    static var previews: some View {
        PopoverOptions()
    }
}
