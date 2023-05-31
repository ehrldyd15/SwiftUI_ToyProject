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
                    .overlay(alignment: .topTrailing) {
                        // 샘플 버튼
                        VStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.black)
                                    }
                            }
                            .showCase(order: 0,
                                      title: "My Current Location",
                                      cornerRadius: 10,
                                      style: .continuous)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "suit.heart.fill")
                                    .foregroundColor(.red)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.black)
                                    }
                            }
                        }
                        .padding(15)
                    }
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
        // 현재 최상위 뷰에 해당 Modifire를 호출하자. 또한, 이것은 한번만 호출되어야 함
        .modifier(ShowCaseRoot(showHighlights: true, onFinished: {
            print("Finished OnBoarding")
        }))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
