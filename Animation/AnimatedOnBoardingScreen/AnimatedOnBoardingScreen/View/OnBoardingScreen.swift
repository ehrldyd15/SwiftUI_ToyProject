//
//  OnBoardingScreen.swift
//  AnimatedOnBoardingScreen
//
//  Created by Do Kiyong on 2022/12/20.
//

import SwiftUI
import Lottie
import UIKit
import Foundation

// https://www.youtube.com/watch?v=QKol0WQpoOs 6:19
// 로띠 안나오는것 확인해볼 것
// 로띠파일 -> https://lottiefiles.com/search?q=Delivery&category=animations&type=free&animations-page=2
struct OnBoardingScreen: View {
    // MARK: OnBoarding Slides Model Data
    @State var onboardingItem: [OnboardingItem] = [
        .init(title: "Request Pickup", subTitle: "Tell us who you're sending it to, what you're sendong and when it's best to pickup the package and we will pick it up at the most convenient time", lottieView: .init(name: "Pickup", bundle: .main)),
        .init(title: "Track Delivery", subTitle: "The best part starts when our courier is on the way to your location, as you will get real time notifications as to the exact location of the courier", lottieView: .init(name: "Transfer", bundle: .main)),
        .init(title: "Receive Package", subTitle: "The journey ends when your package get to it's location. Get notified immediately your package is received at its intended location", lottieView: .init(name: "Delivery", bundle: .main))
    ]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            HStack(spacing: 0) {
                ForEach($onboardingItem) { $item in
                    VStack {
                        // MARK: Top Nav Bar
                        HStack {
                            Button("Back") {
                                
                            }
                            
                            Spacer(minLength: 0)
                            
                            Button("Skip") {
                                
                            }
                        }
                        .tint(Color("Green"))
                        .fontWeight(.bold)
                        
                        // MARK: Movable Slides
                        VStack(spacing: 15) {
                            // MARK: Resizable Lottie View
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
                            
                            
                            Text(item.title)
                                .font(.title.bold())
                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer(minLength: 0)
                        
                        // MARK: Login Button
                        VStack(spacing: 15) {
                            Text("Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(Color("Green"))
                                }
                                .padding(.horizontal, 100)
                            
                            HStack {
                                Text("Terms of Service")
                                
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
                        }
                    }
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItem.count), alignment: .leading)
        }
    }
    
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Resizable Lottie View Without Background
struct ResizableLottieView: UIViewRepresentable {
    @Binding var onboardingItem: OnboardingItem

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        setupLottieView(view)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }

    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Applying Constraints
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]

        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
