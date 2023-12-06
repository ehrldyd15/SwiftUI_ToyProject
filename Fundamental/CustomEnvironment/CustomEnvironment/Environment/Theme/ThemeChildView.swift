//
//  ThemeChildView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

struct ThemeChildView: View {
    @Environment(\.customTheme) var themeColor
    
    var body: some View {
        VStack {
            Text("title")
                .foregroundStyle(themeColor.title)
            Text("subtitle")
                .foregroundStyle(themeColor.subtitle)
        }
        .frame(width: 200, height: 200)
        .background(themeColor.background)
    }

}

#Preview {
    ThemeChildView()
}
