//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 큐(Queue/대기열)의 종류

func task1() {
    print("Task 1 시작")
    sleep(2)
    print("Task 1 완료★")
}

func task2() {
    print("Task 2 시작")
    print("Task 2 완료★")
}

func task3() {
    print("Task 3 시작")
    sleep(1)
    print("Task 3 완료★")
}

func task4() {
    print("Task 4 시작")
    sleep(3)
    print("Task 4 완료★")
}



//: # 메인큐
//: ### 메인큐 = 메인쓰레드("쓰레드1번"을 의미), 한개뿐이고 Serial큐
// 메인큐
let mainQueue = DispatchQueue.main


timeCheck {
    task1()
}


// 위와 아래의 코드는 (의미상)같다.
// (다만, 에러가 나는 것은 뒤에서 설명: sync메서드 주의사항(2) 참고)
//timeCheck{
//    mainQueue.sync {
//        task1()
//    }
//}



//: # 글로벌큐
//: ### 6가지의 Qos를 가지고 있는 글로벌(전역) 대기열

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let defaultQueue = DispatchQueue.global()  // 디폴트 글로벌큐
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)
let unspecifiedQueue = DispatchQueue.global(qos: .unspecified)


timeCheck {

    defaultQueue.async {
        task1()
    }

    defaultQueue.async(qos: .userInitiated) {
        task2()
    }

    defaultQueue.async {
        task3()
    }
}




//: # 프라이빗(커스텀)큐
//: ### 기본적인 설정은 Serial, 다만 Concurrent설정도 가능


let privateQueue = DispatchQueue(label: "com.inflearn.serial")



privateQueue.async {
    task1()
}

privateQueue.async {
    task2()
}

privateQueue.async {
    task3()
}




let prinvateConcurrentQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)


prinvateConcurrentQueue.async {
    task1()
}

prinvateConcurrentQueue.async {
    task2()
}

prinvateConcurrentQueue.async {
    task3()
}





sleep(5)

PlaygroundPage.current.finishExecution()

//: [Next](@next)
