//
//  ContentView.swift
//  Share
//
//  Created by Do Kiyong on 3/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("공유하기 예제")
                .padding()
            
            Button(action: {
                shareContent()
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("공유하기")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
    }
    
    func shareContent() {
        // 공유할 항목 정의
        let textToShare = "공유할 텍스트"
        let url = URL(string: "https://example.com")!
        
        // 공유 시트 생성을 위한 ActivityViewController 호출
        let activityVC = UIActivityViewController(
            activityItems: [textToShare, url],
            applicationActivities: nil
        )
        
        // 현재 창의 rootViewController 가져오기
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            // iPad 대응
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = rootViewController.view
                popover.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            
            rootViewController.present(activityVC, animated: true)
        }
    }
}

#Preview {
    ContentView()
}
