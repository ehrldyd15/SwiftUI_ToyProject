//
//  ContentView.swift
//  TCA_Study
//
//  Created by Do Kiyong on 2/6/24.
//
//https://green1229.tistory.com/282

import SwiftUI
//import ComposableArchitecture

struct ContentView: View {
    var body: some View {
//        MainView(store: .init(initialState: .init(), reducer: mainReducer, environment: .init()))
        VStack {
            
        }
    }
}

#Preview {
    ContentView()
}

//struct SubView: View {
//    var store: Store<SubState, SubAction>
//    
//    var body: some View {
//        WithViewStore(store) { viewStore in
//            VStack(spacing: 20) {
//                Text(viewStore.subTitle)
//                    .font(.body)
//                
//                Button(
//                    action: { viewStore.send(.changeTitleButtonTapped) },
//                    label: { Text("Click for Change title") }
//                )
//            }
//        }
//    }
//}
//
//struct SubState: Equatable {
//    var subTitle: String = "What's the Sub Title"
//}
//
//enum SubAction {
//    case changeTitleButtonTapped
//}
//
//struct SubEnvironment { }
//
//let subReducer = Reducer<SubState, SubAction, SubEnvironment> { state, action, env in
//    switch action {
//    case .changeTitleButtonTapped:
//        state.subTitle = "Tapped Sub title Button"
//        return .none
//    }
//}
//
//struct MainView: View {
//    var store: Store<MainState, MainAction>
//    
//    var body: some View {
//        WithViewStore(store) { viewStore in
//            VStack(spacing: 30) {
//                Text(viewStore.mainTitle)
//                    .font(.title)
//                
//                SubView(
//                    store: store.scope(
//                        state: \.subState,
//                        action: MainAction.subAction
//                    )
//                )
//            }
//        }
//    }
//}
//
//struct MainState: Equatable {
//    var mainTitle: String = "Is Changed Sub Title?"
//    var subState: SubState = .init()
//}
//
//enum MainAction {
//    case subAction(SubAction)
//}
//
//struct MainEnvironment { }
//
//let mainReducer = Reducer.combine([
//    subReducer.pullback(
//        state: \.subState,
//        action: /MainAction.subAction,
//        environment: { _ in
//            SubEnvironment()
//        }
//    ) as Reducer<MainState, MainAction, MainEnvironment>,
//    Reducer<MainState, MainAction, MainEnvironment> { state, action, env in
//        switch action {
//        case .subAction(.changeTitleButtonTapped):
//            state.mainTitle = "Changed Sub title!"
//            return .none
//            
//        case .subAction:
//            return .none
//        }
//    }
//])
