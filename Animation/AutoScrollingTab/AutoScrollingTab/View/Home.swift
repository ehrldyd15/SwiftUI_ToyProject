//
//  Home.swift
//  AutoScrollingTab
//
//  Created by Do Kiyong on 2023/03/20.
//

import SwiftUI

struct Home: View {
    // View properties
    @State private var activeTab: Tab = .men
    @State private var scrollProgress: CGFloat = .zero
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                TabIndicatorView()
                
                TabView(selection: $activeTab) {
                    ForEach(Tab.allCases, id:\.rawValue) { tab in
                        TabImageView(tab)
                            .tag(tab)
                            .offsetX() { rect in
                                let minX = rect.minX
                                let pageOffset = minX - (size.width * CGFloat(tab.index))
//                                print("tab.index -> ", tab.index)
                                print("minX -> ", minX)
                                print("pageOffset -> ", pageOffset)
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    // Tab Indicator View
    @ViewBuilder
    func TabIndicatorView() -> some View {
        GeometryReader {
            let size = $0.size
            
            // 탭 하나의 사이즈는 스크린 사이즈의 1/3로 하고, 나머지는 스크롤처리한다.
            let tabWidth = size.width / 3
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Text(tab.rawValue)
                        .font(.title3.bold())
                        .foregroundColor(activeTab == tab ? .primary : .gray)
                        .frame(width: tabWidth)
                }
            }
            .frame(width: CGFloat(Tab.allCases.count) * tabWidth)
            // Center에서 시작한다.
            .padding(.leading, tabWidth)
            .offset(x: scrollProgress * tabWidth)
        }
        .frame(height: 50)
        .padding(.top, 15)
    }
    
    // Image View
    @ViewBuilder
    func TabImageView(_ tab: Tab) -> some View {
        GeometryReader {
            let size = $0.size
            
            Image(tab.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
