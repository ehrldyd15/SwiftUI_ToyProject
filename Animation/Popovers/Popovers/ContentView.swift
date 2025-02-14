//
//  ContentView.swift
//  Popovers
//
//  Created by Do Kiyong on 2023/02/17.
//

import SwiftUI

//struct ContentView: View {
//    @State var isDisplayTooltip: Bool = true
//    
//    var body: some View {
//        VStack {
//            TooltipView(
//                isDisplayTooltip: $isDisplayTooltip,
//                backgroundColor: .red,
//                borderColor: .blue,
//                borderWidth: 3,
//                padding: 30,
//                tailDirection: .center, // 개발 전
//                hasTail: true,
//                bubbleType: .rectangle,
//                cornerRadius: 0,
//                content: TooltipContentView()
//            )
//           // Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .foregroundColor(.yellow)
//        .onTapGesture {
//            if isDisplayTooltip {
//                isDisplayTooltip = false
//            }
//        }
//        
//    }
//}
//
///**
// TooltipView - 말풍선 UI를 제공하는 뷰
//
// - Parameters:
//    - isDisplayTooltip: 말풍선 표시 여부
//    - backgroundColor: 말풍선의 배경 색상
//    - borderColor: 말풍선의 테두리 색상
//    - borderWidth: 테두리 두께
//    - padding: 내부 패딩 값
//    - tailDirection: 말풍선 꼬리 방향 (`.left`, `.right`, `.center`) // 개발 전
//    - hasTail: 말풍선 꼬리 표시 여부 (`true`, `false`)
//    - bubbleType: 말풍선 형태 (`.rectangle`, `.oval`)
//    - cornerRadius: 테두리 둥글기
//    - content: 말풍선 내부에 들어갈 View
// */
//struct TooltipView<Content: View>: View {
//    
//    @Binding var isDisplayTooltip: Bool
//    
//    var backgroundColor: Color
//    var borderColor: Color
//    var borderWidth: CGFloat
//    var padding: CGFloat
//    var tailDirection: tailDirection
//    var hasTail: Bool
//    var bubbleType: bubbleType
//    var cornerRadius: CGFloat
//    var content: Content
//    
//    var body: some View {
//        VStack(spacing: -1) {
//            Button {
//                isDisplayTooltip.toggle()
//            } label: {
//                Image("tooltip")
//                    .resizable()
//                    .frame(width: 20, height: 20)
//            }
//            
//            TooltipShape(
//                borderColor: borderColor,
//                backgroundColor: backgroundColor,
//                borderWidth: borderWidth,
//                padding: padding, tailDirection: tailDirection, hasTail: hasTail, bubbleType: bubbleType,
//                cornerRadius: cornerRadius,
//                content: content
//            )
//            .opacity(isDisplayTooltip ? 1 : 0)
//        }
//    }
//}
//
//struct TooltipShape<Content: View>: View {
//    var borderColor: Color
//    var backgroundColor: Color
//    var borderWidth: CGFloat
//    var padding: CGFloat
//    var tailDirection: tailDirection
//    var hasTail: Bool
//    var bubbleType: bubbleType
//    var cornerRadius: CGFloat
//    var content: Content
//    var triangleSize: CGSize = CGSize(width: 9, height: 11)
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            if hasTail {
//                CustomTriangleShape(borderColor: borderColor, backgroundColor: backgroundColor, borderWidth: borderWidth, size: triangleSize)
//            }
//            
//            
//            CustomRectangleShape(
//                borderColor: borderColor,
//                backgroundColor: backgroundColor,
//                borderWidth: borderWidth,
//                cornerRadius: cornerRadius,
//                padding: padding,
//                bubbleType: bubbleType,
//                content: content
//            )
//            .padding(.top, hasTail ? triangleSize.height : 0)
//            
//            if hasTail {
//                CustomTriangleShape(borderColor: backgroundColor, backgroundColor: backgroundColor, borderWidth: borderWidth, size: CGSize(width: triangleSize.width-borderWidth, height: triangleSize.height-borderWidth*2))
//                    .padding(.top, borderWidth*3)
//            }
//            
//        }
//        .onTapGesture { } // 터치 제스쳐를 받아 클릭해도 tooltip이 사라지지 않게끔 동작
//    }
//}
//
//struct CustomRectangleShape<Content: View>: View {
//    var borderColor: Color
//    var backgroundColor: Color
//    var borderWidth: CGFloat
//    var cornerRadius: CGFloat
//    var padding: CGFloat
//    var bubbleType: bubbleType
//    var content: Content
//    
//    var body: some View {
//        switch bubbleType {
//        case .rectangle:
//            content
//                .padding(padding)
//                .background(
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .foregroundColor(backgroundColor)
//                        .border(borderColor, width: borderWidth)
////                        .fill(backgroundColor)
////                        .stroke(borderColor, lineWidth: borderWidth)
//                        .shadow(color: .black.opacity(0.1), radius: 5)
//                )
//            
//        case .oval:
//            content
//                .padding(padding)
//                .background(
//                    Ellipse()
//                        .foregroundColor(backgroundColor)
//                        .border(borderColor, width: borderWidth)
////                        .fill(backgroundColor)
////                        .stroke(borderColor, lineWidth: borderWidth)
//                )
//        }
//        
//    }
//}
//
//
//struct CustomTriangleShape: View {
//    var borderColor: Color
//    var backgroundColor: Color
//    var borderWidth: CGFloat
//    var size: CGSize
//    
//    var body: some View {
//        ZStack {
//            Triangle()
//                .foregroundColor(backgroundColor)
//                .border(borderColor, width: borderWidth)
////                .fill(backgroundColor)
////                .stroke(borderColor, lineWidth: borderWidth)
//                .frame(width: size.width, height: size.height)
//        }
//    }
//}
//
//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // 삼각형 위쪽 꼭짓점
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // 오른쪽 아래
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // 왼쪽 아래
//        path.closeSubpath()
//        
//        return path
//    }
//}
//
//enum bubbleType {
//    case rectangle
//    case oval
//}
//
//enum tailDirection {
//    case left
//    case right
//    case center
//}
//
//struct TooltipContentView: View {
//    let textColor: Color = .black
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            Text("성인 1일 권장 칼로리를 기준으로 AI 영양 다이어리 리포트 작성이 진행돼요.\n")
//                .font(.system(size: 12, weight: .regular))
//                .foregroundColor(textColor)
//                .multilineTextAlignment(.leading)
//            
//            HStack(spacing: 0) {
//                Text("성인 여성 1일 권장량 ")
//                    .font(.system(size: 12, weight: .regular))
//                    .foregroundColor(textColor)
//                Text("2000Kcal")
//                    .font(.system(size: 12, weight: .bold))
//                    .foregroundColor(textColor)
//            }
//            
//            HStack(spacing: 0) {
//                Text("성인 남성 1일 권장량 \n")
//                    .font(.system(size: 12, weight: .regular))
//                    .foregroundColor(textColor)
//                Text("2700Kcal\n")
//                    .font(.system(size: 12, weight: .bold))
//                    .foregroundColor(textColor)
//            }
//            
//            Text("원하는 칼로리 변경도 가능해요!")
//                .font(.system(size: 12, weight: .bold))
//                .foregroundColor(textColor)
//        }
//        .frame(width: 166, height: 144)
//        
//    }
//    
//}






struct ContentView: View {
    @State var tooltipVisible = false
    
    var tooltipConfig = DefaultTooltipConfig()
    
    init() {
        self.tooltipConfig.borderColor = .blue
        self.tooltipConfig.borderRadius = 8
        self.tooltipConfig.borderWidth = 2
        self.tooltipConfig.height = 162
        self.tooltipConfig.width = 198
        self.tooltipConfig.shadowColor = .gray
        self.tooltipConfig.shadowRadius = 8
        self.tooltipConfig.shadowOffset = CGPoint(x: 0, y: 0)
    }
    
    var body: some View {
        //        Home()
        
        
        ZStack {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .onTapGesture {
                    self.tooltipVisible = false
                }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("휴대폰으로 내가 먹을 음식을 촬영해 주세요")
                        .font(.system(size: 14))
                    HStack {
                        Text("식단 기록부터 영양분석까지 해드려요.")
                            .font(.system(size: 14))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "pencil.circle")
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
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded {
                                    self.tooltipVisible.toggle()
                                }
                        )
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

