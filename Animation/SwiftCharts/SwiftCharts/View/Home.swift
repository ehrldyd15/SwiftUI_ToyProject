//
//  Home.swift
//  SwiftCharts
//
//  Created by Do Kiyong on 2022/12/15.
//

import SwiftUI
import Charts

struct Home: View {
    // MARK: State Chart Data For Animation Changes
    @State var sampleAnalytics: [SiteView] = sample_analytics
    
    // MARK: View Properties
    @State var currentTab: String = "7 Days"
    
    // MARK: Gesture Properties
    @State var currentActiveItem: SiteView?
    @State var plotWidth: CGFloat = 0
    
    @State var isLineGraph: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: New Chart API
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Views")
                            .fontWeight(.semibold)
                        
                        Picker("", selection: $currentTab) {
                            Text("7 Days")
                                .tag("7 Days")
                            Text("Weak")
                                .tag("Weak")
                            Text("Month")
                                .tag("Month")
                        }
                        .pickerStyle(.segmented)
                        .padding(.leading, 80)
                    }
                    
                    let totalValue = sampleAnalytics.reduce(0.0) { partialResilt, item in
                        item.views + partialResilt
                    }
                    
                    Text(totalValue.stringFormat)
                        .font(.largeTitle.bold())
                    
                    AnimatedCharts()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                }
                
                Toggle("Line Graph", isOn: $isLineGraph)
                    .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Swift Charts")
            // MARK: Simply Updating Values For Segmented Tabs
            .onChange(of: currentTab) { newValue in
                sampleAnalytics = sample_analytics
                
                if newValue != "7 Days" {
                    for (index, _) in sampleAnalytics.enumerated() {
                        sampleAnalytics[index].views = .random(in: 1500...10000)
                    }
                }
                
                // Re-Animating View
                animateGraph(fromChange: true)
            }
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
                // MARK: Animating Graph
                if isLineGraph {
                    LineMark(x: .value("Hour", item.hour, unit: .hour),
                            y: .value("Views", item.animate ? item.views : 0))
                    
                    // Applying Gradient Style
                    // From SwiftUI 4.0 We can Directly Create Gradient From Color
                    .foregroundStyle(Color("Blue").gradient)
                    .interpolationMethod(.catmullRom)
                } else {
                    BarMark(x: .value("Hour", item.hour, unit: .hour),
                            y: .value("Views", item.animate ? item.views : 0))
                    
                    // Applying Gradient Style
                    // From SwiftUI 4.0 We can Directly Create Gradient From Color
                    .foregroundStyle(Color("Blue").gradient)
                }
                
                if isLineGraph {
                    AreaMark(x: .value("Hour", item.hour, unit: .hour),
                            y: .value("Views", item.animate ? item.views : 0))
                    
                    // Applying Gradient Style
                    // From SwiftUI 4.0 We can Directly Create Gradient From Color
                    .foregroundStyle(Color("Blue").opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                }
                
                // MARK: Rule Mark For Currently Dragging Item
                if let currentActiveItem, currentActiveItem.id == item.id {
                    RuleMark(x: .value("Hour", currentActiveItem.hour))
                    // Dotted Style
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                    // MARK: Setting In Middle Of Each Bars
                        .offset(x: (plotWidth / CGFloat(sampleAnalytics.count)) / 2)
                        .annotation(position: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Views")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(currentActiveItem.views.stringFormat)
                                    .font(.title3.bold())
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                        }
                }
            }
        }
        // MARK: Customizing Y-Axis Length
        .chartYScale(domain: 0...(max + 5000))
        // MARK: Gesture To Highlight Current Bar
        .chartOverlay(content: { proxy in
            GeometryReader { innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // MARK: Getting Current Location
                                let location = value.location
                                
                                // Extracting Value From The Location
                                // Swift Charts Gices The Direct Ability to do that
                                // We're going to extract the Date in A-Axis Then with the help of That Date Value We're extracting the current Item
                                
                                // Dont't Forgot to Include the perfect Data Type
                                if let date: Date = proxy.value(atX: location.x) {
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: date)
                                    
                                    if let cirrentItem = sampleAnalytics.first(where: { item in
                                        calendar.component(.hour, from: item.hour) == hour
                                    }) {
                                        print(cirrentItem.views)
                                        self.currentActiveItem = cirrentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                            }.onEnded { value in
                                self.currentActiveItem = nil
                            }
                    )
            }
        })
        .frame(height: 250)
        .onAppear {
            animateGraph()
        }
    }
    
    // MARK: Customizing Y-Axis Length
    func animateGraph(fromChange: Bool = false) {
        for (index, _) in sampleAnalytics.enumerated() {
            // For Some Reason Delay is Not Working
            // Using Dispatch Queue Delay
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)) {
                withAnimation(fromChange ? .easeInOut(duration: 0.8) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension Double {
    
    var stringFormat: String {
        if self > 10000 && self < 999999 {
            return String(format: "%.1fk", self / 10000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999 {
            return String(format: "%.1fM", self / 1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.0f", self)
    }
    
}
