//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # URLSession의 예제
//: ### 또다른 비동기 그룹 함수의 예제

let group = DispatchGroup()

// unsplash.com 무료 이미지 사이트
let base = "https://images.unsplash.com/photo-"

let imageNames = [
    "1579962413362-65c6d6ba55de?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80","1580394693981-254c3aeded6a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3326&q=80", "1579202673506-ca3ce28943ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80", "1535745049887-3cd1c8aef237?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80", "1568389494699-9076492b22e7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=937&q=80",  "1566624790190-511a09f6ddbd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"
]

let userQueue = DispatchQueue.global(qos: .userInitiated)


var downloadedImages: [UIImage] = []

for name in imageNames {
    guard let url = URL(string: "\(base)\(name)") else { continue }
    
    group.enter()
    
    // URL세션 자체가 비동기적 작업의 처리라는 것을 인식할 필요
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        // defer로 클로저의 마지막에 사용하도록 등록할 수있음
        defer { group.leave() }
        
        if error == nil, let data = data, let image = UIImage(data: data) {
            downloadedImages.append(image)
        }
    }
    task.resume()
}



group.notify(queue: userQueue) {
    print("=====모든 다운로드 완료=====")
    PlaygroundPage.current.finishExecution()
}

//: [Next](@next)
