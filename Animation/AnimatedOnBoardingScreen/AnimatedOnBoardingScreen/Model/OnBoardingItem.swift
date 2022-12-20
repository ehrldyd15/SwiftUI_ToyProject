//
//  OnBoardingItem.swift
//  AnimatedOnBoardingScreen
//
//  Created by Do Kiyong on 2022/12/20.
//

import SwiftUI
import Lottie

// MARK: OnBoarding Item Model
struct OnboardingItem: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var lottieView: LottieAnimationView = .init()
}
