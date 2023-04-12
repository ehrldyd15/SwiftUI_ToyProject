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
// https://www.youtube.com/watch?v=23rvgRZVvLM
// https://www.youtube.com/watch?v=OFf5ZEd3Yzw

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
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
            // 그냥 stroke를 쓰게되면 선을 중심으로 두꼐 40짜리 선이 Circle을 테두리를 중심으로 그려진다.
            // 따라서 선 밖과 안쪽에 20씩 두꺼운 그림이 그려지면서 line이 화면 밖을 빠져나가게 된다.
//                .stroke(.blue, lineWidth: 40)
            // Circle의 테두리 안쪽으로 두께 40짜리 선이 그려지도록 해야하므로 strokeBorder를 쓴다.
            // 하지만 strokeBorder는 Shape의 멤버가 아니기 때문에 InsettableShape 프로토콜을 채택하여 쓰도록 한다.
                .strokeBorder(.blue, lineWidth: 40)
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("InsettableShape")
                }

            VStack {
                Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                    .stroke(.red, lineWidth: 1)
//                    .fill(.red)
//                    .fill(.red, style: FillStyle(eoFill: true))
                
                Text("Offset")
                Slider(value: $petalOffset, in: -40...40)
                    .padding([.horizontal, .bottom])
                
                Text("Width")
                Slider(value: $petalWidth, in: 0...100)
                    .padding(.horizontal)
            }
            .tabItem {
                Image(systemName: "3.square.fill")
                Text("Flower")
            }
            
//            Text("path/Shape")
//                .frame(width: 300, height: 300)
//                .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.4, width: 1, height: 0.1), scale: 0.2), width: 50)
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.3), lineWidth: 20)
                .frame(width: 300, height: 200)
                .tabItem {
                    Image(systemName: "4.square.fill")
                    Text("ImagePaint")
                }
            
            VStack {
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 300, height: 300)
                
                Slider(value: $colorCycle)
            }
            .tabItem {
                Image(systemName: "5.square.fill")
                Text("MetalRendering")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        // 많은 수의 gradient, shadow 및 기타 효과를 사용하다보면 성능 문제가 발생할 가능성이 크기 때문에 drawingGroup()를 사용하자
        // drawingGroup()은 최종 표시 전에 뷰의 내용을 offscreen 이미지로 결합한다.
        // offscreen 구성은 애플의 고성능 그래픽 프레임워크인 Metal을 사용하여 복잡한 View를 렌더링하는데 있어 인상적으로 속도를 향상시킨다.
        // view의 내용은 단일 비트맵으로 구성되며, 비트맵은 뷰 대신 표현된다.
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // stride 함수
//        stride(from: 5, to: 30, by: 5).forEach() { (element) in
//            print(element) // 5, 10, 15, 20, 25 (from: 시작, to: 끝(미포함), by: 폭)
//        }
//
//        stride(from: 5, through: 30, by: 5).forEach() { (element) in
//            print(element) // 5, 10, 15, 20, 25, 30 (from: 시작, through: 끝(포함), by: 폭)
//        }
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
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
