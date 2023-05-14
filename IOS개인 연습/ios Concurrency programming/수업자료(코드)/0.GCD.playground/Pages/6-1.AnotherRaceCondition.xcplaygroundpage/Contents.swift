//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 1.RaceCondition(경쟁상황)
//: ### 비동기적인 실행으로(여러쓰레드에서) 하나의 객체에 접근하는 예제

let person = Person(firstName: "길동", lastName: "홍")


person.changeName(firstName: "꺽정", lastName: "임")
person.name


let nameList = [("재석", "유"), ("구라", "김"), ("나래", "박"), ("동엽", "신"), ("세형", "양")]

let concurrentQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)
let nameChangeGroup = DispatchGroup()


//: 비동기작업(여러쓰레드를 사용)의 경우, 한개의 데이터에 접근할때 항상 Thread-safe를 고려해야함
// 이름 바꾸는 작업을 비동기적으로 동시큐(여러쓰레드)에서 접근하기 때문에 일관되지 않은 처리가 일어남
for (idx, name) in nameList.enumerated() {
    concurrentQueue.async(group: nameChangeGroup) {
        usleep(UInt32(10_000 * idx))
        person.changeName(firstName: name.0, lastName: name.1)
        print("현재의 이름: \(person.name)")
    }
}

nameChangeGroup.notify(queue: DispatchQueue.global()) {
    print("마지막 이름은?: \(person.name)")
    //  PlaygroundPage.current.finishExecution()
}

nameChangeGroup.wait()
PlaygroundPage.current.finishExecution()


//: Thread-safe를 고려한 처리는?
//: 1. 7-2.SerialQueueSync 및
//: 2. 7-3.DispatchBarrier에서 해결 예정


//: [Next](@next)
