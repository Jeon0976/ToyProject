//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Priority Inversion(우선순위의 뒤바뀜)
//: ### 세마포어의 사용으로 인해 우선순위가 뒤바뀔수 있는 예제
// 어쨌든, Qos는 다르지만, 모두 글로벌 동시큐
let highQueue = DispatchQueue.global(qos: .userInitiated)
let mediumQueue = DispatchQueue.global(qos: .utility)
let lowQueue = DispatchQueue.global(qos: .background)

let semaphore = DispatchSemaphore(value: 1)


highQueue.async {
    // 3초간 잠재우는 행위로 low퀄리티의 작업이 "세마포어"를 우선 배정받게 됨
    sleep(3)
    semaphore.wait()
    print("====우선순위 높은(high) task 1번====")
    semaphore.signal()
}

for i in 2...11 {
    // 중간 우선순위의 작업은 세마포어로 제한하지 않음
    mediumQueue.async {
        print("====우선순위 중간(medium) task \(i)번====")
        sleep(UInt32(Int.random(in: 1...7)))
    }
}

lowQueue.async {
    semaphore.wait()
    print("====우선순위 낮은(low) task 12번====")
    sleep(5)
    semaphore.signal()
}


// 이 예제에서는 low퀄리티의 작업이 세마포어를 먼저 사용하기 때문에,
// high퀄리티의 작업은 low퀄리티의 작업이 종료해야만 작업을 실행을 시작하게됨

sleep(10)

PlaygroundPage.current.finishExecution()

//: [Next](@next)
