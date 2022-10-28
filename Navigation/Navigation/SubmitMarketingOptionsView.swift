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
}

struct SubmitMarketingOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitMarketingOptionsView()
    }
}
