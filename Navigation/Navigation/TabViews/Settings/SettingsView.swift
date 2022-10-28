//
//  SettingsView.swift
//  Navigation
//
//  Created by Do Kiyong on 2022/10/28.
//

import SwiftUI

enum Screens {
    case marketingOptions
    case submitMarketingOptions
    case appVersion
}

extension Screens: Hashable { }

struct SettingsView: View {
    @EnvironmentObject var settingManager: SettingsNavigationManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.pink
                
                VStack(spacing: 15) {
                    Text("Settings screen")
                    
                    Button("Go to marketing options") {
                        settingManager.push(to: .marketingOptions)
                    }
                    .background(
                        NavigationLink(tag: .marketingOptions,
                                       selection: $settingManager.screen,
                                       destination: {
                                           MarketingOptionView()
                                       }, label: {
                                           EmptyView()
                                       })
                    )
                    
                    Button("Go to app versions") {
                        settingManager.push(to: .appVersion)
                    }
                    .background(
                        NavigationLink(tag: .appVersion,
                                       selection: $settingManager.screen,
                                       destination: {
                                           AppVersionView()
                                       }, label: {
                                           EmptyView()
                                       })
                    )
                }
            }
            .navigationTitle("Settings")
            // 화면 상단 툴바 아이템
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: AppVersionView(),
                                   tag: .appVersion,
                                   selection: $settingManager.screen) {
                        Image(systemName: "mail.stack")
                            .symbolVariant(.fill)
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MarketingOptionView(),
                                   tag: .marketingOptions,
                                   selection: $settingManager.screen) {
                        Image(systemName: "doc.plaintext")
                            .symbolVariant(.fill)
                    }
                    
                    NavigationLink(destination: SubmitMarketingOptionsView(),
                                   tag: .submitMarketingOptions,
                                   selection: $settingManager.screen) {
                        Image(systemName: "paperplane")
                            .symbolVariant(.fill)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
