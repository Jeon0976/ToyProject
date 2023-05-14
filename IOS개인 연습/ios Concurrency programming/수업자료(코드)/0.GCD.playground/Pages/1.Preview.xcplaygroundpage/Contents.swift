//: [Previous](@previous)
import Foundation
import PlaygroundSupport
// 플레이 그라운드 작업 중간에 멈추지 않게 하기 위함
// (비동기작업으로 인해, 플레이그라운드의 모든 작업이 끝난다고 인식할 수 있기때문에 사용)
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 들어가기에 앞서
//: ### 다른 쓰레드를 사용해야할지에 대해 인지하지 못했던 간단했던 작업들
// 간단한 프린트 작업 예시 (컴퓨터, 아이폰은 이정도 작업들은 금방 처리 가능)

func task1() {
    print("Task 1 시작")
    print("Task 1 완료★")
}

func task2() {
    print("Task 2 시작")
    print("Task 2 완료★")
}

func task3() {
    print("Task 3 시작")
    print("Task 3 완료★")
}

func task4() {
    print("Task 4 시작")
    print("Task 4 완료★")
}


task1()
task2()
task3()
task4()


for i in 5...15 {
    print("Task \(i) 시작")
    print("Task \(i) 완료★")
}

print("====완료 출력하기====")



// 작업이 종료되었으니 플레이그라운드 실행 종료 Ok.
PlaygroundPage.current.finishExecution()
//: [Next](@next)
