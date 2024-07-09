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
