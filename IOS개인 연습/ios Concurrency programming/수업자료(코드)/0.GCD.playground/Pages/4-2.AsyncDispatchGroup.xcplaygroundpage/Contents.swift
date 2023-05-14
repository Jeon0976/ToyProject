//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 비동기 디스패치 그룹함수 만들기
//: ### 기존의 비동기API 래핑해서, 비동기 디스패치 그룹함수 만들어 보기

let workingQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)
let defaultQueue = DispatchQueue.global()

let numberArray = [(0,1), (2,3), (4,5), (6,7), (8,9), (10,11)]


//: 1. 기존에 연습했던, 비동기함수 만들기
func asyncAdd(_ input: (Int, Int), runQueue: DispatchQueue, completionQueue: DispatchQueue,
              completion: @escaping (Int, Error?) -> ()) {
    runQueue.async {
        var error: Error?
        error = .none
        
        let result = slowAdd(input)
        completionQueue.async {
            completion(result, error)
        }
    }
}


//: 2. 비동기 디스패치 그룹함수 만들기
// 위와 거의 동일하지만, "디스패치 그룹" 아규먼트 추가적으로 더하기

func asyncAdd_Group(_ input: (Int, Int), runQueue: DispatchQueue, completionQueue: DispatchQueue, group: DispatchGroup, completion: @escaping (Int, Error?) -> ()) {
    
    group.enter()
    asyncAdd(input, runQueue: runQueue, completionQueue: completionQueue) { result, error in
        completion(result, error)
        group.leave()     // 컴플리션 핸들러에서 "퇴장"시점 알기
        
    }
}

//: 3. 사용해보기
// 디스패치 그룹 생성
let wrappedGroup = DispatchGroup()


// 반복문으로 비동기 그룹함수 활용하기
for pair in numberArray {
    asyncAdd_Group(pair, runQueue: workingQueue, completionQueue: defaultQueue, group: wrappedGroup) {
        result, error in
        print("결과값 출력 = \(result)")
    }
}

// 모든 비동기 작업이 끝남을 알림받기
wrappedGroup.notify(queue: defaultQueue) {
    print("====모든 작업이 완료 되었습니다.====")
    PlaygroundPage.current.finishExecution()
}


//: [Next](@next)
