//
//  MemoView.swift
//  TCA_Simple_tutorial
//
//  Created by Do Kiyong on 2022/10/17.
//

import Foundation
import SwiftUI
import ComposableArchitecture

// 도메인 + 상태 (말그대로 데이터 상태)
struct MemoState: Equatable {
    var memos: Memos = []
    var selectedMemo: Memo? = nil
    var isLoading: Bool = false
}

// 도메인 + 액션
// ex) 검색 이라면 검색어 입력, 검색어 삭제
// ex) 할일 이라면 할일 삭제, 할일 추가 등
enum MemoAction: Equatable {
    case fetchItem(_ id: String) // 단일 조회 액션
    case fetchItemResponse(Result<Memo, MemoClient.Failure>) // 단일 조회 액션 응답값
    case fetchAll // 모두 조회 액션
    case fetchAllResponse(Result<Memos, MemoClient.Failure>) // 모두 조회 액션 응답값
}

// 환경설정 주입
struct MemoEnvironment {
    var memoClient: MemoClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

// Reducer는 액션과 상태를 연결시켜주는 역할
let memoReducer = Reducer<MemoState, MemoAction, MemoEnvironment> { state, action, environment in
    // 들어온 액션에 따라 상태를 변경
    switch action {
    case .fetchItem(let memoId):
        enum FetchItemId {}
        
        state.isLoading = true
        
        return environment.memoClient
            .fetchMemoItem(memoId)
            .debounce(id: FetchItemId.self,
                      for: 0.3, scheduler:
                        environment.mainQueue)
            .catchToEffect(MemoAction.fetchItemResponse)
    case .fetchItemResponse(.success(let memo)):
        state.selectedMemo = memo
        state.isLoading = false
        
        return Effect.none // 아무것도 반환하지 않음
    case .fetchItemResponse(.failure):
        state.selectedMemo = nil
        state.isLoading = false
        
        return Effect.none // 아무것도 반환하지 않음
    case .fetchAll:
        enum FetchAllId {}
        
        state.isLoading = true
        
        return environment.memoClient
            .fetchMemos()
            .debounce(id: FetchAllId.self,
                      for: 0.3, scheduler:
                        environment.mainQueue)
            .catchToEffect(MemoAction.fetchAllResponse)
    case .fetchAllResponse(.success(let memos)):
        state.memos = memos
        state.isLoading = false
        
        return Effect.none // 아무것도 반환하지 않음
    case .fetchAllResponse(.failure):
        state.memos = []
        state.isLoading = false
        
        return Effect.none // 아무것도 반환하지 않음
    }
}

struct MemoView: View {
    // store는 상태와 액션을 가지고 있는 센터역할
    let store: Store<MemoState, MemoAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                if viewStore.state.isLoading {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .overlay {
                            ProgressView().tint(.white)
                                .scaleEffect(1.7)
                        }
                        .zIndex(1)
                }
                
                List {
                    Section(header:
                                VStack(spacing: 8) {
                        Button("메모 목록 가져오기", action: {
                            viewStore.send(.fetchAll, animation: .default)
                        })
                        
                        Text("선택된 메모")
                        
                        Text(viewStore.state.selectedMemo?.id ?? "비어있음")
                        
                        Text(viewStore.state.selectedMemo?.title ?? "비어있음")
                    }, content: {
                        ForEach(viewStore.state.memos) { aMemo in
                            Button(aMemo.title, action: {
                                viewStore.send(.fetchItem(aMemo.id), animation: .default)
                            })
                        }
                    })
                }
                .listStyle(PlainListStyle())
            }
        }
    }
    
}
