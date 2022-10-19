//
//  MemoClient.swift
//  TCA_Simple_tutorial
//
//  Created by Do Kiyong on 2022/10/17.
//

import Foundation
import ComposableArchitecture

// Effect를 반환하는 것은 외부에서 발생한 데이터의 변화를 다시 Store로 가져와서 상태를 변경시킨다.
struct MemoClient {
    // 단일 아이템 조회
    var fetchMemoItem: (_ id: String) -> Effect<Memo, Failure>
    // 전체 아이템 조회
    var fetchMemos: () -> Effect<Memos, Failure>
    
    struct Failure: Error, Equatable { }
}

extension MemoClient {
    // MemoClient 자체를 반환한다.
    static let live = Self(
        fetchMemoItem: { id in
            Effect.task {
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "https://603fca51d9528500176060fc.mockapi.io/api/01/todos/\(id)")!)
                
                return try JSONDecoder().decode(Memo.self, from: data)
            }
            .mapError { _ in Failure() }
            .eraseToEffect()
        }, fetchMemos: {
            Effect.task {
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "https://603fca51d9528500176060fc.mockapi.io/api/01/todos/")!)
                
                return try JSONDecoder().decode(Memos.self, from: data)
            }
            .mapError { _ in Failure() }
            .eraseToEffect()
        }
    )
}
