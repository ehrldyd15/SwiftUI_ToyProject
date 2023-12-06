//
//  CountEnvironment.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/6/23.
//

import Foundation
import SwiftUI

struct CountKey: EnvironmentKey {
    static var defaultValue: Int = 100
}

extension EnvironmentValues {
    var customCounter: Int {
        get { self[CountKey.self] }
        set { self[CountKey.self] = newValue }
    }
}
