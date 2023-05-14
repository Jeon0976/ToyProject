//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 다른 쓰레드로 보내기
//: ### 다른 쓰레드로 보낼 수있는 기본 코드 살펴보기
// iOS에서는 기본적으로 GCD/Operation의 개념. 즉, 큐(대기열)을 사용하여 다른 쓰레드에서 일을 하도록 함


// 아래 코드의 의미
//"큐로 보낼꺼야","큐의종류","비동기적으로"
DispatchQueue.global().async {
    
    //다른 쓰레드로 보낼 작업을 배치
    
}


// 위의 방식 또는 아래의 방식으로 사용

let queue = DispatchQueue.global()

queue.async {
    
    //다른 쓰레드로 보낼 작업을 배치
    
}




// 작업의 단위 ===> "하나의 클로저" 안에 보내는 작업 자체가 묶이는 개념
DispatchQueue.global().async {
    print("Task1 시작")
    print("Task1 의 중간작업 1")
    print("Task1 의 중간작업 2")
    print("Task1 의 중간작업 3")
    print("Task1 의 중간작업 4")
    print("Task1 의 중간작업 5")
    print("Task1 종료")
}




//: 또다른 예로 살펴보기
func secondTask0() -> String {
    return "★ 작업1, "
}

func secondTask1(inString: String) -> String {
    return inString + "작업2, "
}

func secondTask2(inString: String) -> String {
    return inString + "작업3 ★"
}



// 순서가 필요한 작업 실행해보기
DispatchQueue.global().async {
    let out0 = secondTask0()
    let out1 = secondTask1(inString: out0)
    let out2 = secondTask2(inString: out1)
    print(out2)
}




sleep(2)

PlaygroundPage.current.finishExecution()
//: [Next](@next)
