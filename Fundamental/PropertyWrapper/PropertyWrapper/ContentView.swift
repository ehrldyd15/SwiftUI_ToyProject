//
//  ContentView.swift
//  PropertyWrapper
//
//  Created by Do Kiyong on 12/7/23.
//

// https://www.youtube.com/watch?v=VXt9fR01ut8&t=394s 13:01

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            TabView {
                Forum()
                    .tabItem {
                        Image(systemName: "bubble.right")
                    }
                Text("두번째 탭")
                    .tabItem {
                        Image(systemName: "house")
                    }
            }
            .navigationTitle("Scrum 스터디 방")
        }
    }
    
}

struct Forum: View {
    @State private var list: [Post] = Post.list
    @State private var showAddView: Bool = false
    @State private var newPost = Post(username: "유저 이름", content: "")
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($list) { $post in
                    NavigationLink {
                        PostDetail(post: $post)
                    } label: {
                        PostRow(post: post)
                    }
                    .tint(.primary)
                }
            }
        }
        .refreshable { }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Button {
                showAddView = true
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .padding()
                    .background(Circle().fill(.white).shadow(radius: 4))
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showAddView) {
            NavigationView {
                PostAdd(editingPost: $newPost)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("취소") {
                                newPost = Post(username: "유저 이름", content: "")
                                showAddView = false
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("게시") {
                                list.insert(newPost, at: 0)
                                showAddView = false
                                newPost = Post(username: "유저 이름", content: "")
                            }
                        }
                    }
            }
        }
    }
}

struct PostAdd: View {
    @FocusState private var focused: Bool
    @Binding var editingPost: Post
    
    var body: some View {
        VStack {
            TextField("포스트를 입력해주세요...", text: $editingPost.content)
                .font(.title)
                .padding()
                .padding(.top)
                .focused($focused)
                .onAppear {
                    focused = true
                }
            
            Spacer()
        }
        .navigationTitle("포스트 게시")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostDetail: View {
    @State private var showEditView: Bool = false
    @Binding var post: Post
    @State private var editingPost = Post(username: "유저 이름", content: "")
    
    var body: some View {
        VStack(spacing: 20) {
            Text(post.username)
            Text(post.content)
                .font(.largeTitle)
            
            Button {
                editingPost = post
                showEditView = true
            } label: {
                Image(systemName: "pencil")
                Text("수정")
            }
            .fullScreenCover(isPresented: $showEditView) {
                NavigationView {
                    PostAdd(editingPost: $editingPost)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("취소") {
                                    showEditView = false
                                }
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("게시") {
                                    post = editingPost
                                    showEditView = false
                                }
                            }
                        }
                }
            }
        }
    }
}

struct PostRow: View {
    let post: Post
    let colors: [Color] = [
        Color.orange, Color.green, Color.purple, Color.pink, Color.blue, Color.yellow, Color.brown, Color.cyan, Color.mint, Color.indigo, Color.teal
    ]
    
    var body: some View {
        HStack {
            Circle()
                .fill(colors.randomElement() ?? .brown)
                .frame(width: 30)
            
            VStack {
                Text(post.username)
                Text(post.content)
                    .font(.title)
            }
            
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
        }
        .padding()
    }
}

struct Post: Identifiable {
    let id = UUID()
    let username: String
    var content: String
}

extension Post {
    static var list: [Post] = [
        Post(username: "프렘", content: "스크럼 스터디 할 사람"),
        Post(username: "민디고", content: "저요저요"),
        Post(username: "천원", content: "저는 Swift 별로 안 좋아해요"),
        Post(username: "쵸비", content: "저도 할래요"),
        Post(username: "라쿤", content: "탈주각"),
        Post(username: "스티브", content: "저도 하고 싶어요")
    ]
}

#Preview {
//    ContentView()
//    PostRow(post: Post(username: "스티브", content: "안녕하세요"))
//    PostDetail(post: Post(username: "스티브", content: "안녕하세요"))
//    PostAdd() { post in
//        
//    }
    ContentView()

}
