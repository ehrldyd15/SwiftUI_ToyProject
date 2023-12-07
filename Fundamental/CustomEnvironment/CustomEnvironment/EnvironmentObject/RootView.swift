//
//  RootView.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/7/23.
//

import SwiftUI

struct RootView: View {
    // @StateObjec는 view의 라이프사이클을 따라간다.
    // RootView가 화면에서 제거되거나 사라질때 flowObject는 메모리에서 해제되기 때문에 observableObject보다 안전
    @StateObject private var flowObject = RootFlowObject()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()
            
            switch flowObject.viewType {
            case .splash:
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            flowObject.viewType = .register
                        }
                    }
            case .register:
                NavigationStack {
                    RegisterView()
                }
                // NavigationStack으로 푸시된 화면들은 제각각 별개로 동작을 하기때문에
                // RegisterView()에다가 .environmentObject(flowObject)를 붙이면
                // RegisterView에서만 flowObject를 사용할수있고 그 다음으로 넘어가는 뷰에서는 사용 불가하다
                // 따라서 NavigationStack에다가 .environmentObject를 붙여준다.
                .environmentObject(flowObject)
            case .home:
                HomeView()
                    .environmentObject(flowObject)
            }
        }
    }
    
}

#Preview {
    RootView()
}
