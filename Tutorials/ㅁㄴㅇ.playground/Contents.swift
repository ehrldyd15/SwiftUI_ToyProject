import UIKit
import Combine

let subject = PassthroughSubject<String, Error>()

subject.sink(receiveCompletion: { completion in
  //에러가 발생한경우도 receiveCompletion 블록이 호출됩니다.
  switch completion {
  case .failure:
    print("Error가 발생하였습니다.")
  case .finished:
    print("데이터의 발행이 끝났습니다.")
  }
}, receiveValue: { value in
  print(value)
})

//데이터를 외부에서 발행할 수 있습니다.
subject.send("A")
subject.send("B")
//데이터의 발행을 종료합니다.
subject.send(completion: .finished)
