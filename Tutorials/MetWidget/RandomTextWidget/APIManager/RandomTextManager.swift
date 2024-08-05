//
//  RandomTextManager.swift
//  MetWidget
//
//  Created by Do Kiyong on 8/5/24.
//

import Foundation

class RandomTextManager {
    
    static var shared = RandomTextManager()
    
    func getTexts(completion: @escaping ([String]) -> ()) {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/?count=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let textModel = try? JSONDecoder().decode(RandomTextModel.self, from: data) else { return }
            
            completion(textModel.datas)
        }.resume()
    }
    
}
