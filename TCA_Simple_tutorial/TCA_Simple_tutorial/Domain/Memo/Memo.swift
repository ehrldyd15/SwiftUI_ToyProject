//
//  Memo.swift
//  TCA_Simple_tutorial
//
//  Created by Do Kiyong on 2022/10/17.
//

import Foundation

// MARK: - Memo
struct Memo: Codable, Equatable, Identifiable {
    let createdAt: String
    let title: String
    let viewCount: String
    let id: String
}

typealias Memos = [Memo]
