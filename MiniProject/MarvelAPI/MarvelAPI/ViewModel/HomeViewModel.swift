//
//  HomeViewModel.swift
//  MarvelAPI
//
//  Created by Do Kiyong on 2023/02/16.
//

import SwiftUI
import Combine
import CryptoKit

class HomeViewModel: ObservableObject {
    @Published var searchQuery = ""
    
    // Combine을 활용한 검색바
    // 검색 Publisher를 취소하는데 사용
    var searchCancellable: AnyCancellable? = nil
    
    // fetched Data
    @Published var fetchedCharacters: [Character]? = nil
    
    // Comic View 데이터
    @Published var fetchedComics: [Comic] = []
    
    @Published var offset: Int = 0
    
    init() {
        // SwiftUI는 @Published를 사용하므로 게시자이다.
        // 따라서 게시자를 명시적으로 정의할 필요가 없다.
        searchCancellable = $searchQuery
        // 반복적인 타이핑을 제거
            .removeDuplicates()
        // 매 타이핑마다 패치할 필요가 없다.
        // 유저가 타이핑을 끝낸 후 0.5초를 기다린다.
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    // 데이터 리셋
                    self.fetchedCharacters = nil
                } else {
                    // 데이터 검색ain
                    self.searchCharacter()
                }
            })
    }
    
    func searchCharacter() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        
        let url = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                
                return
            }
            
            guard let APIData = data else {
                print("no data found")
                
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                
                DispatchQueue.main.async {
                    self.fetchedCharacters = characters.data.results
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    // CryptoKit을 활용하여 해시 생성
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func fetchComics() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        let url = "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                
                return
            }
            
            guard let APIData = data else {
                print("no data found")
                
                return
            }
            
            do {
                let comic = try JSONDecoder().decode(APIComicResult.self, from: APIData)
                
                DispatchQueue.main.async {
                    self.fetchedComics.append(contentsOf: comic.data.results)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
}
