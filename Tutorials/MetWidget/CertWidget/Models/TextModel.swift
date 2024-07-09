//
//  TextModel.swift
//  MetWidget
//
//  Created by Do Kiyong on 7/9/24.
//

import Foundation

struct TextModel: Codable {
    
    enum CodingKeys : String, CodingKey {
        case datas = "data"
    }
    
    let datas: [String]
    
}
