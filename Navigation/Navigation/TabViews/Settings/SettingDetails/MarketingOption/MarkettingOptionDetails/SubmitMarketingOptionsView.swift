//
//  SubmitMarketingOptionsView.swift
//  Navigation
//
//  Created by Do Kiyong on 2022/10/28.
//

import SwiftUI

struct SubmitMarketingOptionsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject var settingManager: SettingsNavigationManager
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Submit Marketing Options screen")
            
            Menu {
                Button("first menu") {

                }

                Button("first menu") {

                }
            } label: {
                Text("menu")
            }
            
            Button("Go to root") {
                settingManager.popToRoot()
            }
            
            Button("Go to previous screen") {
                if #available(iOS 15, *) {
                    dismiss()
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    func samplePopUp() -> some View {
        GroupBox {
            DisclosureGroup("Menu 1") {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
        }
//        Menu {
//            Button() {
//
//            } Label: {
//                Text("first menu")
//            }
//
//            Button() {
//
//            } Label: {
//                Text("second menu")
//            }
//        } Label: {
//            Text("메뉴")
//        }
    }
}

struct SubmitMarketingOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitMarketingOptionsView()
    }
}
