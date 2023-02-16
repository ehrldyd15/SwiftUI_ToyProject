//
//  ComicsView.swift
//  MarvelAPI
//
//  Created by Do Kiyong on 2023/02/16.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicsView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                if homeData.fetchedComics.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                } else {
                    VStack(spacing: 15) {
                        ForEach(homeData.fetchedComics) { comic in
                            ComicRowView(comic: comic)
                        }
                        
                        // GeomtryReader를 활용한 무제한 스크롤
                        if homeData.offset == homeData.fetchedComics.count {
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                  print("fetching new data ....")
                                    homeData.fetchComics()
                                })
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                // 스크롤이 높이를 넘어가면 업데이트
                                if !homeData.fetchedComics.isEmpty && minY < height {
                                    
                                    DispatchQueue.main.async {
                                        // 현재 가져온 comics수에 대한 오프셋 설정
                                        // 그래서 0은 20개를 가져온다
                                        homeData.offset = homeData.fetchedComics.count
                                    }
                                }
                                
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.vertical)
                }
            })
            .navigationTitle("marvel's Comics")
        }
        // 로딩
        .onAppear(perform: {
            if homeData.fetchedComics.isEmpty {
                homeData.fetchComics()
            }
        })
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView()
    }
}

struct ComicRowView: View {
    var comic: Comic
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            WebImage(url: extractImage(data: comic.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(comic.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let description = comic.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
                
                // 링크
                HStack(spacing: 10) {
                    ForEach(comic.urls, id: \.self) { data in
                        NavigationLink(destination: WebView(url: extractURL(data: data)).navigationTitle(extractURLType(data: data)), label: {
                            Text(extractURLType(data: data))
                        })
                    }
                }
            })
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    
    func extractImage(data: [String : String]) -> URL {
        let path = data["path"] ?? ""
        let replacedPath = path.replacingOccurrences(of: "http://", with: "https://")
        
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(replacedPath).\(ext)")!
    }
    
    func extractURL(data: [String : String]) -> URL {
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    func extractURLType(data: [String : String]) -> String {
        let type = data["type"] ?? ""
        
        return type.capitalized
    }
}
