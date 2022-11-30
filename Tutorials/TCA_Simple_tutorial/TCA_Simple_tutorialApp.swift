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
    
    let momoStore = Store(initialState: MemoState(),
                          reducer: memoReducer,
                          environment: MemoEnvironment(memoClient: MemoClient.live,
                                                       mainQueue: .main))
    
    var body: some Scene {
        WindowGroup {
//            ConterView(store: counterStore)
            MemoView(store: momoStore)
        }
    }
}
