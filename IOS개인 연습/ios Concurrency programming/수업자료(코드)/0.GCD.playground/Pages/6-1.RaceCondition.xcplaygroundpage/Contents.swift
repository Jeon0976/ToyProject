//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 1.RaceCondition(경쟁상황)
//: ### 하나의 값(value)에 여러개의 쓰레드가 접근하는 간단한 예제

//: 일반적인, (동기적)상황
var value = 777

// 값을 바꾸는 함수
func changeValue() {
    sleep(2)
    value = 555
}

func changeValue1() {
    sleep(1)
    value = 888
}

func changeValue2() {
    sleep(1)
    value = 0
}


// (동기적 실행) 작업이 다 끝나야 아래코드 실행
changeValue()
changeValue1()
changeValue2()

print("(동기)함수 실행값:", value)



//: 비동기와 경쟁적인 상황
print("\n=== 경쟁 상황 만들어서 실험해보기 ===")

// 프라이빗 시리얼 큐
let queue = DispatchQueue(label: "serial")

value = 777

queue.async {
    changeValue()
}

queue.async {
    changeValue1()
}

queue.async {
    changeValue2()
}


print("(비동기)함수 실행값:", value)


sleep(3)


//: 어떻게 하면 경쟁적인 상황을 해결할 수 있을까?

print("\n=== 이 경우에서의 간단한  해결책 ===")


value = 777

// 동기적으로 보냄(현재의 쓰레드를 block하고 기다림) ===> 경쟁상황을 제거
// (그렇지만 실제로는 이런 코드를 쓰면 안됨. 메인쓰레드를 block하고 기다리기 때문에, UI반응이 느려질 수 있음)
queue.sync {
    changeValue()
}

queue.sync {
    changeValue1()
}

queue.sync {
    changeValue2()
}


print("동기적으로 실행값:", value)



PlaygroundPage.current.finishExecution()

//: [Next](@next)
