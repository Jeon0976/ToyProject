//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 디스패치 그룹(작업들의 모음)
//: ### 그룹지어진 작업들이 어느시점에 모두 완료하는 지가 관심

let workingQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)
let numberArray = [(0,1), (2,3), (4,5), (6,7), (8,9), (10,11)]


//: "디스패치 그룹" 생성하기
// 디스패치 그룹 생성
let group1 = DispatchGroup()        // 디폴트 이니셜라이져로 "디스패치그룹" 생성하기


//: 작업들을 비동기적으로 보낼때 "그룹 꼬리표" 붙이기
for inValue in numberArray {
    // 위에서 생성한 디스패치 그룹을 아규먼트에 넣기
    workingQueue.async(group: group1) {
        let result = slowAdd(inValue)
        print("더한 결과값 출력하기 = \(result)")
    }
}


//: 그룹의 모든 작업이 완료했을때 알림(notify) 받기
let defaultQueue = DispatchQueue.global()

// 그룹의 notify. 작업이 완료하고 어떤 일을 할 것인지 정하기
group1.notify(queue: defaultQueue) {
    print("====그룹1 안의 모든 작업이 완료====")
    //  PlaygroundPage.current.finishExecution()
}



//: (동기적으로)그룹 작업이 끝나길 기다리기
// 그룹작업이 다 끝나야만 다음 작업을 할 수 있는 상황의 앱이라면 wait메서드를 이용하면 된다.

group1.wait(timeout: DispatchTime.distantFuture)


// 다만, wait 메서드를 호출할때는 매우 주의해서 사용해야 한다. 왜냐하면, 이건 🔸동기적으로 작동🔸하고, 현재의 큐에서 "동기적인 요청"이기 때문에 현재의 큐를 블락할 것이기 때문이다.
// 그룹 내에서 현재의 큐를 사용하길 원하는 어떤 작업이 있으면 안된다. 그렇지 않으면 "Deadlock"이 발생할 가능성이 있다.


//: 시간 제한을 걸어두고 기다리기

if group1.wait(timeout: .now() + 60) == .timedOut {
    print("모든 작업이 60초 안에 끝나진 않았습니다.")
}




//: [Next](@next)
