//
//  Home.swift
//  ShowcaseView
//
//  Created by Do Kiyong on 2023/05/30.
//

import SwiftUI
import MapKit

struct Home: View {
    // Apple 공원 지역
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090),
                                                   latitudinalMeters: 1000,
                                                   longitudinalMeters: 1000)
    
    var body: some View {
        // 샘플 뷰
        TabView {
            GeometryReader {
                let safeArea = $0.safeAreaInsets
                
                Map(coordinateRegion: $region)
                    .overlay(alignment: .top, content: {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(height: safeArea.top)
                    })
                    .ignoresSafeArea()
            }
            .tabItem {
                Image(systemName: "macbook.and.iphone")
                Text("Device")
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            
            Text("")
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Items")
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Me")
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
