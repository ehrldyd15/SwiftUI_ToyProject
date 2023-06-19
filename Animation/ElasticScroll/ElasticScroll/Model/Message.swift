//
//  Message.swift
//  ElasticScroll
//
//  Created by Do Kiyong on 2023/06/19.
//

import SwiftUI

struct Message: Identifiable {
    var id: UUID = .init()
    var image: String
    var name: String
    var message: String
    var online: Bool
    var read: Bool
}

let sampleMessages: [Message] = [
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: true, read: false),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: false),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: true),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: true, read: true),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: true, read: false),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: true),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: false),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: true, read: true),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: false),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: true),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: true, read: true),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: true),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: true, read: false),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: false, read: false),
    .init(image: "Pic", name: "SwiftUI", message: "Hello world", online: true, read: true)
]
