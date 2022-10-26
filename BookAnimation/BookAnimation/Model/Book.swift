//
//  Book.swift
//  BookAnimation
//
//  Created by Do Kiyong on 2022/10/25.
//

import Foundation

// MARK: Book Model And Sample Data

struct Book: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var imageName: String
    var author: String
}

var sampleBooks: [Book] = [
    .init(title: "Five Feet Apart", imageName: "Book 1", author: "Reacheal Lippincott"),
    .init(title: "The Alchemist", imageName: "Book 2", author: "William B.Irvine"),
    .init(title: "Booke of Hapiness", imageName: "Book 3", author: "Anne"),
    .init(title: "Five Feet Apart", imageName: "Book 4", author: "William Lippincott"),
    .init(title: "Living Alone", imageName: "Book 5", author: "Jenna Lippincott")
]
