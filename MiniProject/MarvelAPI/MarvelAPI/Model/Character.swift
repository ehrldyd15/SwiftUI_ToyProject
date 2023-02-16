//
//  Character.swift
//  MarvelAPI
//
//  Created by Do Kiyong on 2023/02/16.
//

import SwiftUI

struct APIResult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String : String]
    var urls: [[String : String]]
}
