//
//  ThemeView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

struct ThemeView: View {
    @State private var theme: Theme = themeMonoPink()
    
    var body: some View {
        VStack {
            ThemeChildView()
                .environment(\.customTheme, theme)
            
            HStack {
                Circle()
                    .fill(themeDarkForest().background)
                    .frame(width: 50)
                    .onTapGesture {
                        theme = themeDarkForest()
                    }
                
                Circle()
                    .fill(themeMonoPink().background)
                    .frame(width: 50)
                    .onTapGesture {
                        theme = themeMonoPink()
                    }
            }
        }
    }
}

#Preview {
    ThemeView()
}
