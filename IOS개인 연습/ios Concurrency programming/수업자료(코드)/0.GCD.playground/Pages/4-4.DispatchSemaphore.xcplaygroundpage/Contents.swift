//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 디스패치세마포어(DispatchSemaphore)
//: ### 수기신호: 공유리소스에 접근가능한 작업 수를 제한해야하는 경우

let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInteractive)

// 공유리소스에 접근가능한 작업수를 4개로 제한
let semaphore = DispatchSemaphore(value: 4)


for i in 1...10 {
    group.enter()
    semaphore.wait()
    queue.async(group: group) {
        // 다운로드 시뮬레이팅
        print("시뮬레이팅 \(i)시작")
        sleep(3)
        print("시뮬레이팅 \(i)종료★")
        semaphore.signal()
        group.leave()
    }
}

group.notify(queue: DispatchQueue.global()) {
    print("=====모든 일이 종료됨=====")
//    PlaygroundPage.current.finishExecution()
}



//: ## 실제 다운로드를 세마포어로 제한하는 예제
//: ### 앞의 예제(AnotherEample)를 활용하여 세마포어로 제한

let downloadGroup = DispatchGroup()

// unsplash.com 무료 이미지 사이트
let base = "https://images.unsplash.com/photo-"

let imageNames = [
    "1579962413362-65c6d6ba55de?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80","1580394693981-254c3aeded6a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3326&q=80", "1579202673506-ca3ce28943ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80", "1535745049887-3cd1c8aef237?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80", "1568389494699-9076492b22e7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=937&q=80",  "1566624790190-511a09f6ddbd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"
]

let userQueue = DispatchQueue.global(qos: .userInitiated)

let downloadSemaphore = DispatchSemaphore(value: 4)

var downloadedImages: [UIImage] = []

for name in imageNames {
    guard let url = URL(string: "\(base)\(name)") else { continue }
    
    group.enter()
    downloadSemaphore.wait()
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        defer {
            downloadSemaphore.signal()
            group.leave()
        }
        
        if error == nil, let data = data, let image = UIImage(data: data) {
            downloadedImages.append(image)
        }
    }
    task.resume()
}



group.notify(queue: userQueue) {
    print("=====모든 다운로드 완료=====")
    downloadedImages
    PlaygroundPage.current.finishExecution()
}

//: [Next](@next)
