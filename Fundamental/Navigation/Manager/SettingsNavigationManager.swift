//
//  SettingsNavigationManager.swift
//  Navigation
//
//  Created by Do Kiyong on 2022/10/28.
//

import SwiftUI

final class SettingsNavigationManager: ObservableObject {
    @Published var screen: Screens? {
        didSet {
            print("스크린 : \(screen)")
        }
    }
    
    func push(to screen: Screens) {
        self.screen = screen
    }
    
    func popToRoot() {
        screen = nil
    }
}
