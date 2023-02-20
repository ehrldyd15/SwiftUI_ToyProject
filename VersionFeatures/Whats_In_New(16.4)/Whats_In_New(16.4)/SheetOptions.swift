//
//  SheetOptions.swift
//  Whats_In_New(16.4)
//
//  Created by Do Kiyong on 2023/02/20.
//

import SwiftUI
import MapKit

struct SheetOptions: View {
    @State private var showSheet: Bool = false
    
    var body: some View {
        Map(coordinateRegion: .constant(.init(center: .init(latitude: 37.3346, longitude: -122.0090), latitudinalMeters: 10000, longitudinalMeters: 10000)))
            .ignoresSafeArea()
            .overlay(alignment: .topTrailing) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .foregroundColor(.red)
                }
                .padding()
            }
            .sheet(isPresented: $showSheet) {
//                1.
//                Text("Hello It's me Favorites")
//                    .font(.largeTitle.bold())
//                    .presentationBackground(.ultraThinMaterial) // 시트의 백그라운드를 설정한다.
//                    .presentationDetents([.height(100), .medium, .large]) // 바텀시트 처럼 커스텀
//                    .presentationBackgroundInteraction(.enabled) // 바텀시트가 올라왔을떄 백그라운드에 있는 맵 이용 가능
//                    .presentationBackgroundInteraction(.enabled(upThrough: .height(100))) // 바텀시트 높이가 100일때만 백그라운드 맵 사용 가능
                
//                2.
//                List {
//                    ForEach(1...10, id: \.self) { index in
//                        Text("Row With Index \(index)")
//                    }
//                }
//                .presentationDetents([.medium, .large]) // 바텀시트 처럼 커스텀
//                // 바텀시트가 올라왔을떄 리스트의 길이가 바텀시트를 넘어가서 잘리는 문 제가 있다.
//                // 때문에 바텀시트 내부에서 스크롤을 넣어준다.
//                .presentationContentInteraction(.scrolls) // 바텀시트에 스크롤이 생겨서 리스트를 모두 볼 수 있다.
//                .presentationCernerRadius(50) // 바텀시트의 라운드 설정
            }
    }
}

struct SheetOptions_Previews: PreviewProvider {
    static var previews: some View {
        SheetOptions()
    }
}
