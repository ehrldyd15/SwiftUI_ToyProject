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
// https://www.youtube.com/watch?v=gWoXpULXmww
// https://www.youtube.com/watch?v=27ZvPQMYS6E
// https://www.youtube.com/watch?v=YSBXJvANWSo
// https://www.youtube.com/watch?v=V2fxC92HGnQ

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    @State private var amount = 0.0
    
    @State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount2 = 1.0
    @State private var hue = 0.6
    
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
                Text("Path / Shape")
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
                    Text("Insettable Shape")
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
                    Text("Image Paint")
                }
            
            VStack {
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 300, height: 300)
                
                Slider(value: $colorCycle)
            }
            .tabItem {
                Image(systemName: "5.square.fill")
                Text("Metal Rendering")
            }
            
            VStack {
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .saturation(amount)
                    .blur(radius: (1 - amount) * 20)
                
                Slider(value: $amount)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
            .tabItem {
                Image(systemName: "6.square.fill")
                Text("Blurs, Blending and More")
            }
            
            Trapezoid(insetAmount: insetAmount)
                .frame(width: 200, height: 100)
                .onTapGesture {
                    withAnimation {
                        insetAmount = Double.random(in: 10...90)
                    }
                }
                .tabItem {
                    Image(systemName: "7.square.fill")
                    Text("Simple Shapes")
                }
            
            Checkerboard(rows: rows, columns: columns)
                .onTapGesture {
                    withAnimation(.linear(duration: 3)) {
                        rows = 8
                        columns = 16
                    }
                }
                .tabItem {
                    Image(systemName: "8.square.fill")
                    Text("Complex Shapes")
                }
            
            VStack(spacing: 0) {
                Spacer()
                
                Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount2)
                    .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                    .frame(width: 300, height: 300)
                
                Spacer()
                
                Group {
                    Text("Inner radius: \(Int(innerRadius))")
                    Slider(value: $innerRadius, in: 10...150, step: 1)
                        .padding([.horizontal, .bottom])

                    Text("Outer radius: \(Int(outerRadius))")
                    Slider(value: $outerRadius, in: 10...150, step: 1)
                        .padding([.horizontal, .bottom])

                    Text("Distance: \(Int(distance))")
                    Slider(value: $distance, in: 1...150, step: 1)
                        .padding([.horizontal, .bottom])

                    Text("Amount: \(amount2, format: .number.precision(.fractionLength(2)))")
                    Slider(value: $amount2)
                        .padding([.horizontal, .bottom])

                    Text("Color")
                    Slider(value: $hue)
                        .padding(.horizontal)
                }
            }
            .tabItem {
                Image(systemName: "9.square.fill")
                Text("Spirograph")
            }
        }
    }
}

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b

        while b != 0 {
            let temp = b
            
            b = a % b
            a = temp
        }

        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount

        var path = Path()

        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct Trapezoid: Shape {
    var insetAmount: Double
    
    // SwiftUI 애니메이션 효과가 적용되는 조건이 따로 있다.
    // SwiftUI의 애니메이션 효과는 뷰의 상태가 변경되었을 때, 상태 A -> 상태 B로 점차 바뀌면서 애니메이션 효과를 주게 된다.
    // 만약 뷰의 scale이 1.0 -> 2.0으로 변경되었다면, 1.0에서 2.0으로 바로 바뀌는 것이 아니라, scale = 1.0, 1.1, 1.2, ..., 2.0이 적용되면서 애니메이션 효과를 주는 것이다.
    // 그런데 위의 insetAmount 뷰의 상태는 아니기 때문에 애니메이션 효과가 적용되지 않는다.
    // 따라서 animatableData를 구현하면 애니메이션이 작동한다.
    var animatableData: Double { // ✅
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
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
