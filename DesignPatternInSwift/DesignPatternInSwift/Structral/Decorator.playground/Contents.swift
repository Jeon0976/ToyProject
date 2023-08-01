import UIKit

// 네트워크 요청을 표현하는 인터페이스 정의
protocol NetworkRequest {
    var headers: [String: String] { get }
}

// 기본 요청 클래스
class BasicRequest: NetworkRequest {
    var headers: [String : String] {
        return ["Content-Type":"application/json"]
    }
}

// NetworkRequest 인터페이스를 따르는 Decorator
class NetworkRequestDecorator: NetworkRequest {
    private let decoratedRequest: NetworkRequest
    
    init(_ decoratedRequest: NetworkRequest) {
        self.decoratedRequest = decoratedRequest
    }
    
    var headers: [String : String] {
        return decoratedRequest.headers
    }
}

// 이 Decorator를 상속받아 각각의 추가 헤더를 구현하는 클래스들을 정의
class AuthenticatedRequest: NetworkRequestDecorator {
    override var headers: [String: String] {
        var headers = super.headers
        headers["Authorization"] = "Bearer some_auth_token"
        return headers
    }
}

class AcceptLanguageRequest: NetworkRequestDecorator {
    override var headers: [String : String] {
        var headers = super.headers
        headers["Accept-Language"] = "ko-KR"
        return headers
    }
}


var request: NetworkRequest = BasicRequest()
print(request.headers)

request = AuthenticatedRequest(request)
print(request.headers)

request = AcceptLanguageRequest(request)
print(request.headers)
