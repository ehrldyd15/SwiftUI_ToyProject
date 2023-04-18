//
//  ContentView.swift
//  CombineTutorial
//
//  Created by Do Kiyong on 2023/04/17.
//

import SwiftUI
import Combine

//https://medium.com/harrythegreat/swift-combine-%EC%9E%85%EB%AC%B8%ED%95%98%EA%B8%B0-%EA%B0%80%EC%9D%B4%EB%93%9C-1-525ccb94af57
//https://medium.com/harrythegreat/swift-combine-%EC%9E%85%EB%AC%B8%EA%B0%80%EC%9D%B4%EB%93%9C2-publisher-subscribe-operator-723ed5d17e70
//https://medium.com/harrythegreat/swift-combine-%EC%9E%85%EB%AC%B8%ED%95%98%EA%B8%B03-%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC%EC%9A%94%EC%B2%AD-f36d6a32af14

struct ContentView: View {
    let provider = (1...10).publisher // ✅ 1
    
    let publisher = ["A","B","C","D","E","F","G"].publisher // ✅ 2
    
    let subject = PassthroughSubject<String, Error>() // ✅ 4
    
    let currentStatus = CurrentValueSubject<Bool, Error>(true) // ✅ 5
    
    let externalProvider = PassthroughSubject<String, Never>() // ✅ 6
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            // ✅ 1
            provider.sink(receiveCompletion: { _ in
                print("데이터 전달이 끝났습니다.")
            }, receiveValue: { data in
                print(data)
            })
            
            // ✅ 2
            let subscriber = CustomSubscrbier()
            publisher.subscribe(subscriber)

            // ✅ 3
            let formatter = NumberFormatter()
            formatter.numberStyle = .ordinal
            (1...10).publisher.map{
                formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
            }.sink{
                print($0)
            }
            
            // ✅ 4
            subject.sink(receiveCompletion: { completion in
                // 에러가 발생한경우도 receiveCompletion 블록이 호출
                switch completion {
                case .failure:
                    print("Error가 발생하였습니다.")
                case .finished:
                    print("데이터의 발행이 끝났습니다.")
                }
            }, receiveValue: { value in
                print(value)
            })
            
            subject.send("A")
            subject.send("B")
            subject.send(completion: .finished)

            // ✅ 5
            currentStatus.sink(receiveCompletion: { completion in
              switch completion {
              case .failure:
                print("Error가 발생하였습니다.")
              case .finished:
                print("데이터의 발행이 끝났습니다.")
              }
            }, receiveValue: { value in
              print(value)
            })

            // 데이터를 외부에서 발행할
            print("초기값은 \(currentStatus.value)입니다.")
            currentStatus.send(false) // false 값을 주입
            // value값을 변경해도 값이 발행
            currentStatus.value = true

            // ✅ 6
            let anyCancleable = externalProvider.sink{ steam in
                    print("전달받은데이터 \(steam)")
            }
            
            externalProvider.send("A")
            externalProvider.send("B")
            externalProvider.send("C")
            anyCancleable.cancel() //데이터 발행을 중단
            externalProvider.send("D")
            
            // ✅ 6
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

            // dataTaskPublsiher는 URLSession에서 제공하는 Publisher입니다.
            let cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder()) // 전달받은 데이터를 JSON형식으로 Decode합니다.
            .replaceError(with: []) // 에러가 발생할경우 에러를 전달하지않습니다.
            .eraseToAnyPublisher()
            .sink(receiveValue: { posts in
                print("전달받은 데이터는 총 \(posts.count)개 입니다.")
            })
        

            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// ✅ 2
class CustomSubscrbier: Subscriber {
    typealias Input = String // 성공타입
    typealias Failure = Never // 실패타입

    func receive(completion: Subscribers.Completion<Never>) {
        print("모든 데이터의 발행이 완료되었습니다.")
    }

    func receive(subscription: Subscription) {
        print("데이터의 구독을 시작합니다.")
        subscription.request(.unlimited)
//        구독할 데이터의 개수를 제한하지않습니다.
        
//        데이터의 구독을 시작합니다.
//        데이터를 받았습니다. A
//        데이터를 받았습니다. B
//        데이터를 받았습니다. C
//        데이터를 받았습니다. D
//        데이터를 받았습니다. E
//        데이터를 받았습니다. F
//        데이터를 받았습니다. G
//        모든 데이터의 발행이 완료되었습니다.
        
//        subscription.request(.max(2))
//        unlimited로 된 설정을 바꾸어 구독받을 데이터의 수를 변경
        
//        데이터의 구독을 시작합니다.
//        데이터를 받았습니다. A
//        데이터를 받았습니다. B
//        모든 데이터가 발행되지 않았기 때문에 completion는 호출되지 않는다.
        
    }

    func receive(_ input: String) -> Subscribers.Demand {
        print("데이터를 받았습니다.", input)
        return .none
//        none으로 리턴하면 현재 데이터 스트림을 유지
//        unlimited로 설정하면 10개의 데이터를 모두 구독한다.
    }
    
}

// ✅ 6

enum HTTPError: LocalizedError {
    case statusCode
    case post
}

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
