//
//  ContentView.swift
//  Drawing
//
//  Created by Do Kiyong on 2023/03/23.
//

import SwiftUI

// https://www.youtube.com/watch?v=FnwI1I5-8cE&t=19s
// https://www.youtube.com/watch?v=xTRhYKjp5nk
// https://www.youtube.com/watch?v=HkSoE0j8u90
// https://www.youtube.com/watch?v=sQ89JRq0kvg

struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                HStack() {
                    // 상단 꼭지점이 꺠져버림
                    Path { path in
                        path.move(to: CGPoint(x: 60, y: 60))
                        path.addLine(to: CGPoint(x: 35, y: 110))
                        path.addLine(to: CGPoint(x: 85, y: 110))
                        path.addLine(to: CGPoint(x: 60, y: 60))
                    }
                    .stroke(.blue, lineWidth: 10)
                            
                    // 이를 해결하기위해서..
                    Path { path in
                        path.move(to: CGPoint(x: 60, y: 60))
                        path.addLine(to: CGPoint(x: 35, y: 110))
                        path.addLine(to: CGPoint(x: 85, y: 110))
                        path.addLine(to: CGPoint(x: 60, y: 60))
                        path.closeSubpath() // closeSubpath를 쓰면 깨진 꼭지점이 복구된다.
                    }
                    .stroke(.blue, lineWidth: 10)
                    
                    // stroke의 꼭지점에 round를 주면 closeSubpath를 쓰지 않아도 된다. 하지만 디자인 차이 때문에 상황에 맞게 쓰자
                    Path { path in
                        path.move(to: CGPoint(x: 60, y: 60))
                        path.addLine(to: CGPoint(x: 35, y: 110))
                        path.addLine(to: CGPoint(x: 85, y: 110))
                        path.addLine(to: CGPoint(x: 60, y: 60))
                    }
                    .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                }
                .frame(height: 100)
                .padding()
                
                HStack {
                    Triangle()
                        .fill(.red)
                        .frame(width: 100, height: 100)
                    
                    Triangle()
                        .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .frame(width: 100, height: 100)
                }
                .padding()
                
                HStack {
                    Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                        .stroke(.blue, lineWidth: 10)
                        .frame(width: 100, height: 100)
                }
                .padding()
                
                Spacer()
            }
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Path/Shape")
                }

            Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                .strokeBorder(.blue, lineWidth: 40)
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("First")
                }

            Text("path/Shape")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("First")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifieredStart = startAngle - rotationAdjustment
        let modifieredEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifieredStart, endAngle: modifieredEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        
        return arc
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}
