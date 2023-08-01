import UIKit

// Handler
// anyobject 하는 이유 -> setNext에서 nextHandler값 대입하기 때문
// 구조체는 값을 바꿀려면 mutating해야하는데 class는 필요없다
// class만이 이 protocol를 채택할 것이라고 명시
protocol Handler: AnyObject {
    var nextHandler: Handler? { get set }
    
    func setNext(handler: Handler)
    func handle(request: String) -> String?
}

extension Handler {
    func setNext(handler: Handler) {
        if self.nextHandler == nil {
            self.nextHandler = handler
        } else {
            self.nextHandler?.setNext(handler: handler)
        }
    }
    
    func handle(request: String) -> String? {
        return nextHandler?.handle(request: request)
    }
}

// Concrete Handler
class TomatoHandler: Handler {
    var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        print("토마토 기계 전달 완료")
        if request == "토마토" {
            return "tomato success"
        } else {
            if let response = nextHandler?.handle(request: request) {
                return response
            } else {
                return "요청 실패"
            }
        }
    }
}

class OnionHandler: Handler {
    var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        print("양파 기계 전달 완료")
        if request == "양파" {
            return "onion success"
        } else {
            if let response = nextHandler?.handle(request: request) {
                return response
            } else {
                return "요청 실패"
            }
        }
    }
}

class LettuceHandler: Handler {
    var nextHandler: Handler?

    func handle(request: String) -> String? {
        print("양상추 기계 전달 완료")
        if request == "양상추" {
            return "양상추 손질 완성!"
        } else {
            if let response = nextHandler?.handle(request: request) {
                return response
            } else {
                return "요청에 실패했습니다."
            }
        }
    }
}

// Client
class Client {
    private var firstHandler: Handler?
    
    func request(request: String) -> String {
        return self.firstHandler?.handle(request: request) ?? "firstHandler를 설정해주세요"
    }
    
    func addHandler(handler: Handler) {
        if let firstHandler = firstHandler {
            firstHandler.setNext(handler: handler)
        } else {
            self.firstHandler = handler
        }
    }
}

let client = Client()

let tomato = TomatoHandler()
let onion = OnionHandler()
let lettuce = LettuceHandler()

client.addHandler(handler: tomato)
client.addHandler(handler: onion)
client.addHandler(handler: lettuce)

print(client.request(request: "양파"))
