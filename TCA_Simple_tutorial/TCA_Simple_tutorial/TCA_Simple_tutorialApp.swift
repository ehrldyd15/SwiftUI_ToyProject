//
//  TCA_Simple_tutorialApp.swift
//  TCA_Simple_tutorial
//
//  Created by Do Kiyong on 2022/10/12.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_Simple_tutorialApp: App {
    let counterStore = Store(initialState: CounterState(),
                             reducer: counterReducer,
                             environment: CounterEnvironment())
    
    var body: some Scene {
        WindowGroup {
            ConterView(store: counterStore)
        }
    }
}
