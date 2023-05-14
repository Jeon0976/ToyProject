//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 비동기오퍼레이션
//: ### 오퍼레이션내에서 비동기함수를 다루려고 할 때 사용해야함
//: ### (상태 수동관리를 위한 추상 비동기 오퍼레이션)

//: ## 추상비동기오퍼레이션(필요할때, 복사해서 사용하면 됨)
// 추상 비동기 오퍼레이션의 정의==============================
class AsyncOperation: Operation {
    // Enum 생성
    enum State: String {
        case ready, executing, finished
        
        // KVO notifications을 위한 keyPath설정
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        } // isReady/isExecuting/isFinished
    }
    
    // 직접 관리하기 위한 상태 변수 생성
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)

        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncOperation {
    // 상태속성은 모두 read-only
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {  // 무조건 true로 리턴
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}

//=====================================================

//: ## 비동기 오퍼레이션의 사용
//: 1.비동기오퍼레이션 상속해서 오퍼레이션 정의
class SumOperation: AsyncOperation {
    var lhs: Int
    var rhs: Int
    var result: Int?
    
    // 초기화메서드 포함(속성 설정 때문에)
    init(lhs: Int, rhs: Int) {
        self.lhs = lhs
        self.rhs = rhs
        super.init()
    }

    override func main() {
        asyncAdd_OpQ(lhs: lhs, rhs: rhs) { result in
            self.result = result
            self.state = .finished   // 컴플리션 핸들러에서 상태를 .finished로 셋팅
        }
    }
}

//: 2. 오퍼레이션 인스턴스 생성하고, 오퍼레이션큐에 넣어서 사용
let input = [(1,5), (5,8), (6,1), (3,9), (6,12), (1,0)]

let additionQueue = OperationQueue()

for (lhs, rhs) in input {
    let operation = SumOperation(lhs: lhs, rhs: rhs)
    operation.completionBlock = {
        guard let result = operation.result else { return }
        print("\(lhs) + \(rhs) = \(result)")
    }
    additionQueue.addOperation(operation)
}

sleep(5)
PlaygroundPage.current.finishExecution()





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

//: [Next](@next)
