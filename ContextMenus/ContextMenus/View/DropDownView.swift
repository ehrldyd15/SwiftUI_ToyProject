//
//  DropDownView.swift
//  ContextMenus
//
//  Created by Do Kiyong on 2022/10/31.
//

import SwiftUI

enum LeftRightMode {
    case left
    case right
}

struct DropDownView: View {
    @Binding var expand: Bool // 팝업의 노출 여부
    @Binding var munus: [MenuList] // 리스트의 데이터
    
    var popupWidth: CGFloat = 0 // 팝업의 가로 사이즈 (참고로 세로는 리스트 갯수에 따름)
    var horizontalPadding: CGFloat = 0 // 팝업과 단말기의 좌, 우 여백
    
    var leftRightMode: LeftRightMode // 왼쪽 팝업, 오른쪽 팝업 선택 (팝업의 위치는 위의 horizontalPadding 변수로 조정한다.)
    
    var body: some View {
        HStack {
            if leftRightMode == .right {
                Spacer()
            }

            VStack(spacing: 0) {
                ForEach(Array(munus.enumerated()), id: \.1) { (index, element) in
                    VStack(spacing: 0) {
                        Button(action: {
                            self.expand.toggle()
                            // ✅ 버튼 눌렀을 때 액션은 여기에 작성
                            print("\(element.munu) 눌렀다")
                        }, label: {
                            Text(element.munu)
                                // ✅ 텍스트의 가로 길이와 왼쪽 정렬 (디자인 가이드에 따라 수치를 변경해 줄 것)
                                .frame(maxWidth: popupWidth, alignment: .leading)
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding([.top, .bottom], 10)
                                .padding(.horizontal)
                        })
                        
                        Capsule()
                            .foregroundColor(index != (munus.count - 1) ? Color.gray.opacity(0.2) : Color.clear)
                            // ✅ 구분선의 가로 길이 (디자인 가이드에 따라 수치를 변경해 줄 것)
                            .frame(maxWidth: popupWidth, maxHeight: 1)
                            .padding(.horizontal, 10)
                    }
                }
            }
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.2), lineWidth: 1)
                    .shadow(color: .gray, radius: 5, x: -2, y: 2)
            )
            
            if leftRightMode == .left {
                Spacer()
            }
        }
        // ✅ 패딩은 팝업뷰와 우측여백의 수치를 정의한다.
        .padding(.horizontal, horizontalPadding)
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
