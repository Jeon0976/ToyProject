//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 오퍼레이션 취소 사례
//: ### 오퍼레이션큐를 전체관리하는 객체를 만들어보는 사례

//: ## 기본오퍼레이션 정의

class SumOperation: Operation {
    let inputPair: (Int, Int)
    var output: Int?
    
    init(input: (Int, Int)) {
        inputPair = input
        super.init()
    }
    
    override func main() {
        if isCancelled { return }
        output = slowAdd(inputPair)
    }
}


//: ## 오퍼레이션큐와 오퍼레이션을 관리하기 위한 기본 GroupAdd클래스
//: ### 클래스내에 (동시)오퍼레이션큐 및 (시리얼)오퍼레이션큐가 다 존재함
class GroupAdd {
    let queue = OperationQueue()
    let appendQueue = OperationQueue()
    
    var outputArray = [(Int, Int, Int)]()
    
    init(input: [(Int, Int)]) {    // 배열을 가지고 생성
        // 일단 생성시 큐 일시중지 시켜놓기
        queue.isSuspended = true
        queue.maxConcurrentOperationCount = 2
        appendQueue.maxConcurrentOperationCount = 1
        generateOperations(input)
    }
    
    // 반복문으로 오퍼레이션을 생성하는 메서드
    func generateOperations(_ numberArray: [(Int, Int)]) {
        for pair in numberArray {
            let operation = SumOperation(input: pair)
            operation.completionBlock = {
                if operation.isCancelled { return }
                guard let result = operation.output else { return }
                self.appendQueue.addOperation {
                    self.outputArray.append((pair.0, pair.1, result))
                }
            }
            queue.addOperation(operation)
        }
    }
    
    func start() {
        queue.isSuspended = false
    }
    
    func cancel() {
        queue.cancelAllOperations()
    }
    
    func wait() {
        queue.waitUntilAllOperationsAreFinished()
    }
}



//: ## 정의한 클래스 사용해보기

let numberArray = [(1,2), (3,4), (5,6), (7,8), (9,10)]

// 모두 관리하는 클래스 생성하기
let groupAdd = GroupAdd(input: numberArray)


startClock()   // 시간재기 시작

groupAdd.start()   // 클래스에 정의된 일시중지를 푸는 기능(isSuspended = false)

//: cancel()메서드 실험해보기
//groupAdd.cancel()

groupAdd.wait()

stopClock()   // 시간재기 끝

//: 결과값 살펴보기
groupAdd.outputArray





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
