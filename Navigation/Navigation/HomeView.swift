//
//  HomeView.swift
//  Navigation
//
//  Created by Do Kiyong on 2022/10/28.
//

import SwiftUI

struct HomeView: View {
    @State private var shouldShowDetail: Bool = false
    @State private var shouldShowDocument: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.mint
                VStack(spacing: 20) {
                    Text("Home screen")
                    
                    NavigationLink("#1 Go to a screen example 1", destination: Text("screen example 1"))
                    
                    NavigationLink(destination: Text("profile screen")) {
                        Image(systemName: "person")
                            .symbolVariant(.fill.circle)
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                    
                    Group {
                        Button("Trigger detail Push") {
                            shouldShowDetail.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        
                        NavigationLink("Go to detail", isActive: $shouldShowDetail) {
                            Text("Showing detail Screen")
                        }
                    }
                    
                    Group {
                        Button("Trigger document Push") {
                            shouldShowDocument.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        
                        NavigationLink(isActive: $shouldShowDocument) {
                            DocumentsDetailView(showDocumentsDetail: $shouldShowDocument)
                        } label: {
                            Image(systemName: "doc")
                                .symbolVariant(.fill.circle)
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
