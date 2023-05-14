//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # DispatchWorkItem
//: ### 작업을 클로저에 담아 미리 생성한 후(캡슐화), 나중에 사용가능한 방법

let item1 = DispatchWorkItem(qos: .utility) {
    print("Task 1 시작")
    sleep(2)
    print("Task 1 완료★")
}


let item2 = DispatchWorkItem(qos: .utility) {
    print("Task 2 시작")
    print("Task 2 완료★")
}



let queue = DispatchQueue(label: "com.inflearn.serial")



//timeCheck {
queue.async(execute: item1)
queue.async(execute: item2)
//}

//: 1. DispatchWorkItem의 빈약한 <취소> 기능

sleep(3)
item2.cancel()





//또 다른 함수내에서는 아래와 같이 사용 가능
//if item2.isCancelled {
//
//}


//: 2. DispatchWorkItem의 빈약한 <순서> 기능

let queue2 = DispatchQueue(label: "com.inflearn.second", attributes: .concurrent)


let workItem3 = DispatchWorkItem {
    print("Task 3 시작")
    sleep(2)
    print("Task 3 완료★")
}

let workItem4 = DispatchWorkItem {
    print("Task 4 시작")
    print("Task 4 완료★")
}


// 다음 실행할 "디스패치워크아이템"을 지정
workItem3.notify(queue: DispatchQueue.global(), execute: workItem4)

queue2.async(execute: workItem3)





sleep(4)
PlaygroundPage.current.finishExecution()

//: [Next](@next)
