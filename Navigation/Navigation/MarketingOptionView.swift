//
//  MarketingOptionView.swift
//  Navigation
//
//  Created by Do Kiyong on 2022/10/28.
//

import SwiftUI

struct MarketingOptionView: View {
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("Marketing Options screen")
                
                NavigationLink("Go to submit marketing Options screen", destination: SubmitMarketingOptionsView())
            }
        }
    }
}

struct MarketingOptionView_Previews: PreviewProvider {
    static var previews: some View {
        MarketingOptionView()
    }
}
