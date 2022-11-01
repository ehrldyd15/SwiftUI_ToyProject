//
//  FilterItem.swift
//  ActionSheets_CheckBox
//
//  Created by Do Kiyong on 2022/11/01.
//

import Foundation

struct FilterItem: Identifiable {
    var id = UUID().uuidString
    var title: String
    var checked: Bool
}


