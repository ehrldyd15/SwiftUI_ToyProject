//
//  ContentView.swift
//  Navigation
//
//  Created by Do Kiyong on 2022/10/28.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var settingNavigationManager = SettingsNavigationManager()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SettingsView()
                .environmentObject(settingNavigationManager)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
