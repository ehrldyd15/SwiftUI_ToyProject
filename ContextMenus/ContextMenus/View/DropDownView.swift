//
//  DropDownView.swift
//  ContextMenus
//
//  Created by Do Kiyong on 2022/10/31.
//

import SwiftUI

struct DropDownView: View {
    @Binding var expand: Bool
    @Binding var munus: [MenuList]
    
    var body: some View {
        HStack {
            Spacer()
            
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
                                .frame(maxWidth: 150, alignment: .leading)
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding([.top, .bottom], 10)
                                .padding(.horizontal)
                        })
                        
                        Capsule()
                            .foregroundColor(index != (munus.count - 1) ? Color.gray.opacity(0.2) : Color.clear)
                            // ✅ 구분선의 가로 길이 (디자인 가이드에 따라 수치를 변경해 줄 것)
                            .frame(maxWidth: 150, maxHeight: 1)
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
        }
        // ✅ 패딩은 팝업뷰와 우측여백의 정의한다.
        // ✅ 디자인 가이드에 따라 수치를 변경해 줄 것
        .padding(.horizontal, 20)
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
