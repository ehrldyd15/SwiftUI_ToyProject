//
//  Store.swift
//  CustomEnvironment
//
//  Created by Do Kiyong on 12/7/23.
//

import Foundation
import Combine

// ObservableObject을 채택한 Store의 name이 바뀌던지 item이 바뀌던지 Store를 사용하는 모든 뷰를 다시 그리게 된다.
// 즉, 이것은 불필요한 렌더링을 초래
class Store: ObservableObject {
    @Published var name: String = ""
    @Published var item: Item = Item()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // 클래스 자체는 참조타입이기 때문에 참조값 내부의 타입이 바뀌더라도 참조값 자체는 바뀌지 않기 때문에 이를 objectWillChange를 통해서 알려줘야한다.
        item.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }.store(in: &cancellables)
    }
}

class Item: ObservableObject {
    // name의 값이 변경되면 objectWillChange는 뷰에 값 변경 여부를 알려주는데
    // 뷰에서 값의 바인딩이 아닌 값 변경을 시도하면 objectWillChange Item 내부에서만 값 변경 여부를 알게된다.(Store에서는 값 변경을 모른다는 얘기)
    // 결국 name의변경으로 인하여 Item자체의 변경을 Combine을 통하여 Store에 알려줘야 하는 것이다. (Store의 init()을 참고)
    @Published var name: String = "item name"
    @Published var price: Int = 0
}
