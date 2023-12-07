//
//  OStore.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/7/23.
//

import Foundation
import Observation

// Observation의 @Observable에서는 name이 바뀌면 name을 사용하는 뷰만 업데이트 되고
// item이 바뀌면 item을 사용하는 뷰만 업데이트 된다.
// 즉, 불필요한 렌더링을 줄일 수 있다.
@Observable
class OStore {
    var name: String = ""
    var item: OItem = OItem()
}

@Observable
class OItem {
    // 결국 name의 변경으로 인하여 dependencies인 name의 변경을 OStore에 알려주는 것이다.
    var name: String = "observation item"
    var price: Int = 0
}
