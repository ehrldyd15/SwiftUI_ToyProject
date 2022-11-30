//
//  MenuListModel.swift
//  ContextMenus
//
//  Created by Do Kiyong on 2022/10/31.
//

import Foundation

struct MenuList: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var munu: String
}
