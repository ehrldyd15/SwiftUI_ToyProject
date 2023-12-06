//
//  CustomTheme.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import Foundation
import SwiftUI

struct ThemeKey: EnvironmentKey {
    static var defaultValue: Theme = themeMonoPink()
}

extension EnvironmentValues {
    var customTheme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

extension View {
    func theme (_ theme: Theme) -> some View {
        environment(\.customTheme, theme)
    }
}
