//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Lazy Var와 관련된 이슈

// 디스패치 커스텀 동시큐의 생성
let queue = DispatchQueue(label: "test", qos: .default, attributes:[.initiallyInactive, .concurrent])

// 디스패치그룹 생성
let group1 = DispatchGroup()



//: ## 1) Thread-safe하지 않은 Lazy var의 경우
// 🔸🔸 1번 케이스 ====> 메모리에 여러개가 생기는 이슈
// lazy var에 대한 실험 코드
class SharedInstanceClass1 {
    lazy var testVar = {
        return Int.random(in: 0..<99)
    }()
}

// 일단 객체 생성
let instance1 = SharedInstanceClass1()


// 실제 비동기 작업 실행
for i in 0 ..< 10 {
    group1.enter()
    queue.async(group: group1) {
        print("id:\(i), lazy var 이슈:\(instance1.testVar)")
        group1.leave()
    }
}

group1.notify(queue: DispatchQueue.global()){
    print("lazy var 이슈가 생기는 모든 작업의 완료.")
}

queue.activate()
group1.wait()



//: ## 2) 시리얼큐+Sync로 해결(Thread-safe처리)
//: ### 객체 내부에서 처리하는 방법
// 🔸🔸 2번 케이스 ====> 시리얼큐로 해결(엄격한 Thread-safe)
class SharedInstanceClass2 {
    let serialQueue = DispatchQueue(label: "serial")
    
    lazy var testVar = {
        return Int.random(in: 0...100)
    }()
    
    // 객체 내부에서 시리얼큐로 다시 testVar에 접근하도록
    var readVar: Int {
        serialQueue.sync {
            return testVar
        }
    }
}

// 디스패치그룹 생성
let group2 = DispatchGroup()

// 객체 생성
let instance2 = SharedInstanceClass2()

// 실제 비동기 작업 실행
for i in 0 ..< 10 {
    group2.enter()
    queue.async(group: group2) {
        print("id:\(i), lazy var 이슈:\(instance2.readVar)")
        group2.leave()
    }
}

group2.notify(queue: DispatchQueue.global()){
  print("시리얼큐로 해결한 모든 작업의 완료.")
}

queue.activate()
group1.wait()




//: ## 3) Dispatch Barrier로 해결(Thread-safe처리)
//: ### 보내는 작업자체를 배리어처리하는 방법
// 🔸🔸 3번 케이스 ====> 배러어작업(Dispatch Barrier)으로 해결(Thread-safe)
class SharedInstanceClass3 {
    lazy var testVar = {
        return Int.random(in: 0...100)
    }()
}


// 디스패치그룹 생성
let group3 = DispatchGroup()

// 객체 생성
let instance3 = SharedInstanceClass3()

// 실제 비동기 작업 실행
//for i in 0 ..< 10 {
//    group3.enter()
//    queue.async(flags: .barrier) {
//        print("id:\(i), lazy var 이슈:\(instance3.testVar)")
//        group3.leave()
//    }
//}
//
//group3.notify(queue: DispatchQueue.global()){
//  print("디스패치 배리어로 해결한 모든 작업의 완료.")
//}




//: ## DispatchSemaphore로 해결(Thread-safe처리)
// 🔸🔸 4번 케이스 ====> 디스패치 세마포어(DispatchSemaphore)으로 해결(Thread-safe)
class SharedInstanceClass4 {
    lazy var testVar = {
        return Int.random(in: 0...100)
    }()
}


// 디스패치그룹 생성
let group4 = DispatchGroup()

// 객체 생성
let instance4 = SharedInstanceClass4()

let semaphore = DispatchSemaphore(value: 1)


// 실제 비동기 작업 실행
for i in 0 ..< 10 {
    group4.enter()
    semaphore.wait()
    queue.async(group: group4) {
        print("id:\(i), lazy var 이슈:\(instance4.testVar)")
        group4.leave()
        semaphore.signal()
    }
}

group4.notify(queue: DispatchQueue.global()){
    print("디스패치 세마포어로 해결한 모든 작업의 완료.")
}





PlaygroundPage.current.finishExecution()

//: [Next](@next)
