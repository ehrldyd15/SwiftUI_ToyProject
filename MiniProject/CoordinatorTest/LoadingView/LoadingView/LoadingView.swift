//
//  LoadingView.swift
//  LoadingView
//
//  Created by Do Kiyong on 11/22/23.
//

import SwiftUI
import Lottie
import UIKit

public struct MetLoadingView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            LottieView(fileName: "loading")
                .frame(width: 300, height: 100)
        }
    }
    
}

struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    let animationView = LottieAnimationView()
    
    var fileName: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        if let bundle = Bundle(identifier: "com.SwiftToyProject.www.LoadingView") {
            animationView.animation = LottieAnimation.named(fileName, bundle: bundle)
        }
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        // 컨테이너의 넓이와 높이를 자동으로 지정할 수 있도록
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        // 자동완성 기능
        NSLayoutConstraint.activate([
            // 레이아웃의 높이와 넓이의 제약
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        animationView.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {

    }
    
}

