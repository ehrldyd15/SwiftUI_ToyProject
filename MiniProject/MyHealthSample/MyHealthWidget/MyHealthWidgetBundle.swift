//
//  MyHealthWidgetBundle.swift
//  MyHealthWidget
//
//  Created by Do Kiyong on 5/9/25.
//

import WidgetKit
import SwiftUI

@main
struct MyHealthWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyHealthWidget()
        MyHealthWidgetControl()
        MyHealthWidgetLiveActivity()
    }
}
