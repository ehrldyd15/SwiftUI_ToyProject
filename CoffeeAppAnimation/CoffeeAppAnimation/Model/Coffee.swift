//
//  Coffee.swift
//  CoffeeAppAnimation
//
//  Created by Do Kiyong on 2022/11/07.
//

import SwiftUI

struct Coffee: Identifiable {
    var id: UUID = .init()
    var imageName: String
    var title: String
    var price: String
}

var coffee: [Coffee] = [
    .init(imageName: "item1", title: "녹차라떼\n아이스", price: "3.90"),
    .init(imageName: "item2", title: "아메리카노\n아이스", price: "2.30"),
    .init(imageName: "item3", title: "청포도쥬스\n생크림", price: "9.20"),
    .init(imageName: "item4", title: "카페모카\n생크림", price: "12.30"),
    .init(imageName: "item5", title: "해이즐넛 아메리카노\n아이스", price: "5.90")
]
