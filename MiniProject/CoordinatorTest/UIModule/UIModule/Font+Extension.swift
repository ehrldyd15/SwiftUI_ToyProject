//
//  Font+Extension.swift
//  UIModule
//
//  Created by Do Kiyong on 11/21/23.
//

import SwiftUI

// https://nsios.tistory.com/196

public extension Font {
    
    enum PretendardWeight: String, CaseIterable {
        case regular = "Pretendard-Regular"
        case medium = "Pretendard-Medium"
        case semiBold = "Pretendard-SemiBold"
        case bold = "Pretendard-Bold"
        case black = "Pretendard-Black"
    }
    
    static func pretendard(size: CGFloat, weight: PretendardWeight = .regular) -> Font {
        .custom(weight.rawValue, size: size)
    }
    
//    static func registerFont() {
//        Font.PretendardWeight.allCases.forEach {
//            guard let url = Bundle.uiBundle?.url(forResource: "\($0.rawValue)", withExtension: ".otf"),
//                  CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil) else {
//                print("fail register font")
//                return
//            }
//        }
//    }
    
}
