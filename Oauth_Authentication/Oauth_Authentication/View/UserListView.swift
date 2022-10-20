//
//  UserListView.swift
//  Oauth_Authentication
//
//  Created by Do Kiyong on 2022/10/20.
//

import Foundation
import SwiftUI

// 사용자 목록 뷰
struct UserListView: View {
    @State var users: [UserData] = [
        UserData(id: 0, name: "호호호1", email: "hohoho@emailcom", avatar: "https://www.gravatar.com/avatar/b87c0cd09c8c06be1d50f18d2104c814.jpg?s=200&d=robohash"),
        UserData(id: 1, name: "호호호2", email: "hohoho@email.com", avatar: "https://www.gravatar.com/avatar/b87c0cd09c8c06be1d50f18d2104c814.jpg?s=200&d=robohash"),
        UserData(id: 2, name: "호호호3", email: "hohoho@email.com", avatar: "https://www.gravatar.com/avatar/b87c0cd09c8c06be1d50f18d2104c814.jpg?s=200&d=robohash"),
    ]
    
    var body: some View {
        List(users) { aUser in
            NavigationLink(destination: OtherUserProfileView(userData: aUser), label: {
                HStack {
                    AsyncImage(url: URL(string: aUser.avatar)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 120, height: 120, alignment: .center)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120, alignment: .center)
                        case .failure:
                            Image(systemName: "person.fill.questionmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120, alignment: .center)
                        @unknown default:
                            EmptyView()
                                .frame(width: 120, height: 120, alignment: .center)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(aUser.name).font(.title3)
                        Text(aUser.email).font(.callout)
                    }
                    
                    Spacer()
                }
            })
        }
        .navigationTitle("사용자 목록")
    }
}
