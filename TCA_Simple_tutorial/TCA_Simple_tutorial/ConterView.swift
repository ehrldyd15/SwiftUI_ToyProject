//
//  ContentView.swift
//  TCA_Simple_tutorial
//
//  Created by Do Kiyong on 2022/10/12.
//

import SwiftUI
import ComposableArchitecture

// 도메인 + 상태 (말그대로 데이터 상태)
struct CounterState: Equatable {
    var count = 0
}

// 도메인 + 액션
// ex) 검색 이라면 검색어 입력, 검색어 삭제
// ex) 할일 이라면 할일 삭제, 할일 추가 등
enum CounterAction: Equatable {
    case addCount // 카운트를 더하는 액션
    case subtractCount // 카운트를 빼는 액션
}

struct CounterEnvironment { }

// Reducer는 액션과 상태를 연결시켜주는 역할
let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, environment in
    // 들어온 액션에 따라 상태를 변경
    switch action {
    case .addCount:
        state.count += 1
        
        return Effect.none // 아무것도 반환하지 않음
    case .subtractCount:
        state.count -= 1
        
        return Effect.none // 아무것도 반환하지 않음
    }
}

struct ConterView: View {
    // store는 상태와 액션을 가지고 있는 센터역할
    let store: Store<CounterState, CounterAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("count: \(viewStore.state.count)")
                    .padding()
                HStack {
                    // viewStore.send를 통하여 store에 어떤 액션을 실행할 것인지 전송해 준다.
                    Button("더하기", action: { viewStore.send(.addCount) })
                    
                    Button("빼기", action: { viewStore.send(.subtractCount) })
                }
            }

        }
        

    }
}

//struct ConterView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConterView()
//    }
//}
