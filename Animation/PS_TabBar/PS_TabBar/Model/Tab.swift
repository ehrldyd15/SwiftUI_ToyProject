//
//  Tab.swift
//  PS_TabBar
//
//  Created by Do Kiyong on 2023/02/21.
//

import SwiftUI

// 탭 아이템 Enum case
// Raw value는 이미지 이름으로 한다.
enum Tab: String, CaseIterable {
    case play = "gamecontroller.fill"
    case explore = "paperplane.fill"
    case store = "playstation.logo"
    case library = "books.vertical.fill"
    case search = "magnifyingglass"
    
    // 각 Enum case의 index
    var index: CGFloat {
        return CGFloat(Tab.allCases.firstIndex(of: self) ?? 0)
    }
    
    // Enum case의 총 숫자
    static var count: CGFloat {
        return CGFloat(Tab.allCases.count)
    }
}
