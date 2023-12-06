//
//  Theme.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import SwiftUI

protocol Theme {
    var background: Color { get }
    var title: Color { get }
    var subtitle: Color { get }
}

struct themeMonoPink: Theme {
    var background: Color = Color("MonoPink/background", bundle: nil)
    var title: Color = Color("MonoPink/title", bundle: nil)
    var subtitle: Color = Color("MonoPink/subtitle", bundle: nil)
}

struct themeDarkForest: Theme {
    var background: Color = Color("DarkForest/background", bundle: nil)
    var title: Color = Color("DarkForest/title", bundle: nil)
    var subtitle: Color = Color("DarkForest/subtitle", bundle: nil)
}
