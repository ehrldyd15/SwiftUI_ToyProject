//
//  Home.swift
//  SwiftCharts
//
//  Created by Do Kiyong on 2022/12/15.
//

import SwiftUI
import Charts

//https://www.youtube.com/watch?v=xS-fGYDD0qk&t=191s 3:45

struct Home: View {
    // MARK: State Chart Data For Animation Changes
    @State var sampleAnalytics: [SiteView] = sample_analytics
    // MARK: View Properties
    @State var currentTab: String = "7 Days"
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: New Chart API
                AnimatedCharts()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Swift Charts")
        }
    }
    
    @ViewBuilder
    func AnimatedCharts() -> some View {
        // 최대값 추출
        // 클로저 내부에서 순서대로 값 비교 후 조건에 맞게 최대값을 반환한다
        let max = sampleAnalytics.max { item1, item2 in
            return item1.views < item2.views
        }?.views ?? 0
        
        Chart {
            ForEach(sampleAnalytics) { item in
                // MARK: Bar Graph
                BarMark(x: .value("Hour", item.hour, unit: .hour),
                        y: .value("Views", item.views))
            }
        }
        // MARK: Customizing Y-Axis Length
        .chartYScale(domain: 0...(max + 5000))
        .frame(height: 250)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
