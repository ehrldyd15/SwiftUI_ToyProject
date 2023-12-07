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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct Porum: View {
    @State private var list: [Post] = Post.list
    @State private var showAddView: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(list) { post in
                    NavigationLink {
                        PostDetail(post: post)
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
                
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .padding()
                    .background(Circle().fill(.white).shadow(radius: 4))
            }
            .padding()
        }
        .sheet(isPresented: $showAddView) {
            PostAdd { post in
                
            }
        }
    }
}

struct PostAdd: View {
    @FocusState private var focused: Bool
    @Environment(\.dismiss) private var dismiss
    
    @State private var text: String = ""
    
    let action: (_ post: Post) -> ()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("포스트를 입력해주세요...", text: $text)
                    .font(.title)
                    .padding()
                    .padding(.top)
                    .focused($focused)
                    .onAppear {
                        focused = true
                    }
                
                Spacer()
            }
            .navigationTitle("포스트 개시")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("게시") {
                        let newPost = Post(username: "유저이름", content: text)
                        action(newPost)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct PostDetail: View {
    let post: Post
    var body: some View {
        VStack(spacing: 20) {
            Text(post.username)
            Text(post.content)
                .font(.largeTitle)
            
            Button {
                
            } label: {
                Image(systemName: "pencil")
                Text("수정")
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
    let content: String
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
    NavigationView {
        Porum()
    }
}
