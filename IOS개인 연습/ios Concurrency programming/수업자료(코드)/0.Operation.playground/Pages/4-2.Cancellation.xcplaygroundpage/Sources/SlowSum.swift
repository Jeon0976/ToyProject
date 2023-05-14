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

import Foundation

public func slowAdd(_ input: (Int, Int)) -> Int {
    sleep(1)
    return input.0 + input.1
}


// 🎾 진행률(퍼센트) 전달하고 => 작업의 취소여부를 받아처리하는 함수(작업취소여부에 따라 중간에 배열을 뱉을 수 있음)
// (반복문을 내부적으로 구현)
public func slowAddArray(_ input: [(Int, Int)], progress: ((Double) -> (Bool))? = nil) -> [Int] {
    var results = [Int]()
    for pair in input {
        results.append(slowAdd(pair))
        
        if let progress = progress {    // "progress 함수"가 있을 때 진행되는 구문
            
            // 🔸 isCancelled = true(취소되었을때)는 중간에 results배열을 반환
            if progress(Double(results.count) / Double(input.count)) { return results }
        }
    }
    // 🔸 isCancelled = false(취소 안되었을때)는 최종 결과인 results배열을 반환
    return results
}



// 🎾 디스패치큐에서 비동기로 처리하는 함수로
private let workerQueue = DispatchQueue(label: "com.raywenderlich.slowsum", attributes: DispatchQueue.Attributes.concurrent)

public func asyncAdd_GCD(_ input: (Int, Int), completionQueue: DispatchQueue, completion:@escaping (Int) -> ()) {
    workerQueue.async {
        let result = slowAdd(input)
        completionQueue.async {
            completion(result)
        }
    }
}


private let additionQueue = OperationQueue()

public func asyncAdd_OpQ(lhs: Int, rhs: Int, callback: @escaping (Int) -> ()) {
    additionQueue.addOperation {
        sleep(1)
        callback(lhs + rhs)
    }
}
