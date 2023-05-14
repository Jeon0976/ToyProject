//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 오퍼레이션 취소
//: ### 오퍼레이션취소는 isCancelled = true로만 설정됨
//: ### (실제로 작업 진행을 멈출 수 있도록 구현할 필요가 있음)

//: ## ArraySumOperation(1번 케이스)
//: ### 취소여부를 내가 판단 -> 중지시킴
// 튜플 배열을 더해서 배열로 만드는 커스텀 오퍼레이션
class ArraySumOperation: Operation {
    let inputArray: [(Int, Int)]
    var outputArray = [Int]()
    
    init(input: [(Int, Int)]) {
        inputArray = input
        super.init()
    }
    
    override func main() {
        // 더해서 배열에 넣기
        for pair in inputArray {
            if isCancelled { return }
            outputArray.append(slowAdd(pair))
        }
    }
}


//: ## 정의된 오퍼레이션 사용(1번 케이스)
// 사용할 튜플 배열
let numberArray = [(1,2), (3,4), (5,6), (7,8), (9,10)]


let queue = OperationQueue()

// 오퍼레이션(케이스1번) 객체 생성
//let arraySumOperation = ArraySumOperation(input: numberArray)


//startClock()
//arraySumOperation.completionBlock = {
//    if arraySumOperation.isCancelled { return }
//    arraySumOperation.outputArray
//    stopClock()
//}

// 오퍼레이션를 오퍼레이션큐에 넣어서 비동기적으로 사용하기
//queue.addOperation(arraySumOperation)


//: 실제로 몇초 후에 작업 취소해보기
// 4초후에 멈춰보기
//sleep(2)
//arraySumOperation.cancel()
// 아직 시작을 안했다면, ====> (start()가 체크함)오퍼레이션이 시작을 안함을 의미






//: ## AnotherArraySumOperation(2번 케이스)
//: ### 취소여부를 전달 -> 원래함수가 판단/중지시킴
// 조금 다른 방식으로 만든 커스텀 오퍼레이션
class AnotherArraySumOperation: Operation {
    let inputArray: [(Int, Int)]
    var outputArray: [Int]?
    
    init(input: [(Int, Int)]) {
        inputArray = input
        super.init()
    }
    
    // 🎾 반복문이 직접 배치되지 않기에 중단시키는 것이 조금 난해할 수 있음
    override func main() {
        // 반복문이 다른 함수에서 진행되는 경우의 예시 ====> 반복문을 방해하는 것이 어려움
        outputArray = slowAddArray(inputArray) { progress in
            print("배열의 \(progress*100)%가 진행되었습니다.")
            return self.isCancelled     // 취소여부를 리턴
        }
    }
}


//: ## 정의된 오퍼레이션 사용(2번 케이스)
// 반복문이 배치되지 않은(반복문 내장하고 있고, progress판단하는) 오퍼레이션 실행
let anotherArraySumOperation = AnotherArraySumOperation(input: numberArray)

let queue2 = OperationQueue()


startClock()
anotherArraySumOperation.completionBlock = {
//    if anotherArraySumOperation.isCancelled { return }    // 실제작업 취소는 컴플리션도 실행안되길 바람
    stopClock()
    anotherArraySumOperation.outputArray
//    PlaygroundPage.current.finishExecution()
}

queue2.addOperation(anotherArraySumOperation)


//: 실제로 몇초 후에 작업 취소해보기
// 4초후에 멈춰보기
sleep(3)
anotherArraySumOperation.cancel()          // queue2.cancelAllOperations()




PlaygroundPage.current.finishExecution()
//: [Next](@next)


/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
