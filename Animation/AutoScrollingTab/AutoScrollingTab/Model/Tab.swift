//
//  Tab.swift
//  AutoScrollingTab
//
//  Created by Do Kiyong on 2023/03/20.
//

import SwiftUI

// Enum Tab Cases
// rawValue -> 이미지 이름으로 한다
enum Tab: String, CaseIterable {
    case men = "Men"
    case women = "Women"
    case kids = "Kids"
    case living = "Home"
    case game = "Games"
    case outing = "Outing"
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
    
    var count: Int {
        return Tab.allCases.count
    }
}
