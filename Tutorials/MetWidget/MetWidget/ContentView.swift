//
//  ContentView.swift
//  MetWidget
//
//  Created by Do Kiyong on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            gettext(completion: { data in
                print("@@@@@data: ", data)
            })
        }
    }
    
    func gettext(completion: @escaping ([String]) -> ()) {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/?count=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let textModel = try? JSONDecoder().decode(TextModel.self, from: data) else { return }
            
            completion(textModel.datas)
        }.resume()
    }
}

#Preview {
    ContentView()
}

struct TextModel: Codable {
    
    enum CodingKeys : String, CodingKey {
        case datas = "data"
    }
    
    let datas: [String]
    
}
