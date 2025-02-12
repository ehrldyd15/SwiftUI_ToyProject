//
//  ContentView.swift
//  Popovers
//
//  Created by Do Kiyong on 2023/02/17.
//

import SwiftUI

struct ContentView: View {
    @State var tooltipVisible = false
    
    var tooltipConfig = DefaultTooltipConfig()
    
    init() {
        self.tooltipConfig.borderWidth = 5
        self.tooltipConfig.borderColor = .blue
        self.tooltipConfig.height = 149
        self.tooltipConfig.width = 198
    }

    var body: some View {
//        Home()
        VStack {
                Button("Tooltip") {
                    self.tooltipVisible = !self.tooltipVisible
                }
                .tooltip(self.tooltipVisible, config: tooltipConfig) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("성인 1일 권장 칼로리를 기준으로\nAI영양 다이어리 리포트 작성이\n진행돼요.")
                            .font(.system(size: 12))
                        Text("성인 1일 권장량 2,000Kcal")
                            .font(.system(size: 12))
                        Text("원하는 칼로리 변경도 가능해요!")
                            .font(.system(size: 12))
                    }

                }

        }
        .ignoresSafeArea()
        .onTapGesture {
            self.tooltipVisible.toggle()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

