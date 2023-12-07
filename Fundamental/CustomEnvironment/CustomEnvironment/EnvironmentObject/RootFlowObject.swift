//
//  RootFlowObject.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/7/23.
//

import Foundation

class RootFlowObject: ObservableObject {
    
    enum CurrentViewType {
        case splash
        case register
        case home
    }
    
    // @Published로 선언된 프로퍼티의 값이 변경되면 뷰의 body를 다시 그려주게된다.
    @Published var viewType: CurrentViewType = .splash
    
}

// Observation을 임포트해주면 ObservableObject 프로토콜을 따르지도 않고 @Published도 제거가 가능하다

//import Foundation
//import Observation
//
//@Observable
//class RootFlowObject {
//    
//    enum CurrentViewType {
//        case splash
//        case register
//        case home
//    }
//
//    var viewType: CurrentViewType = .splash
//    
//}
