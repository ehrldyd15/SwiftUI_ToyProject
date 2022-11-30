//
//  Home.swift
//  BottomSheetDrawer
//
//  Created by Do Kiyong on 2022/11/02.
//

import SwiftUI

struct Home: View {
    // Search Text Binding Value
    @State var searchText = ""
    
    // Gesture Properties
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // 이미지를 위한 프레임을 알기 위함
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                
                Image("BG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
            }
            .blur(radius: getBlurRadius())
            .ignoresSafeArea()
            
            // 드래그 제스처의 높이를 얻기 위함
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                
                return AnyView(
                    ZStack {
                        // Blur 생성
                        BlurView(style: .systemThinMaterialDark)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                        
                        VStack {
                            VStack {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 60, height: 4)
                                
                                TextField("Search", text: $searchText)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(
                                        BlurView(style: .dark)
                                    )
                                    .cornerRadius(10)
                                    .colorScheme(.dark)
                                    .padding(.top, 10)
                            }
                            .frame(height: 100)
   
                            // 스크롤뷰 콘텐츠
                            ScrollView(.vertical, showsIndicators: false, content: {
                                BottomContent()
                            })
                        }
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                        .offset(y: height - 100)
                        .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                        .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.height
                            
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height - 100
                            
                            withAnimation {
                                // 드래그 이동 상태 로직
                                // 위 아래 중간
                                if -offset > 100 && -offset < maxHeight / 2 {
                                    // 중간
                                    offset = -(maxHeight / 3)
                                } else if -offset > maxHeight / 2 {
                                    offset = -maxHeight
                                } else {
                                    offset = 0
                                }
                            }
                            
                            // 마지막 offset을 저장해야 제스쳐가 계속 마지막 위취에서 부터 움직일 수 있다.
                            lastOffset = offset
                        }))
                )
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
     
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        
        return progress * 30
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
