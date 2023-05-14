/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import PlaygroundSupport

// Tell the playground to continue running, even after it thinks execution has ended.
// You need to do this when working with background tasks.
PlaygroundPage.current.needsIndefiniteExecution = true

//let high = DispatchQueue.global(qos: .userInteractive)
//let medium = DispatchQueue.global(qos: .userInitiated)
//let low = DispatchQueue.global(qos: .background)
//
//let semaphore = DispatchSemaphore(value: 1)
//
//high.async {
//    // Wait 2 seconds just to be sure all the other tasks have enqueued
//    Thread.sleep(forTimeInterval: 2)
//    semaphore.wait()
//    defer { semaphore.signal() }
//
//    print("High priority task is now running")
//}
//
//for i in 1 ... 10 {
//    medium.async {
//        let waitTime = Double(exactly: arc4random_uniform(7))!
//        print("Running medium task \(i)")
//        Thread.sleep(forTimeInterval: waitTime)
//    }
//}
//
//low.async {
//    semaphore.wait()
//    defer { semaphore.signal() }
//
//    print("Running long, lowest priority task")
//    Thread.sleep(forTimeInterval: 5)
//}
//

//
//private let threadSafeCountQueue = DispatchQueue(label: " ")
//private var _count = 0
//public var count: Int {
//    get {
//        return threadSafeCountQueue.sync {
//            _count
//        }
//    }
//    set {
//        threadSafeCountQueue.sync {
//            _count = newValue
//        }
//    }
//}
//
//let concurrent = DispatchQueue(label: "TEs",attributes: .concurrent)
//let group = DispatchGroup()
//
//for _ in 0..<30000 {
//    concurrent.async(group: group) {
//        count += 1
//    }
////    print(count)
//}
//
//group.notify(queue: DispatchQueue.global()) {
//    print(count)
//}
////
//group.notify(queue: .main) {
//    print(count)
//}

//let semaphoreA = DispatchSemaphore(value: 1)
//let semaphoreB = DispatchSemaphore(value: 1)
//
//DispatchQueue.global().async {
//    semaphoreA.wait()
//    print("Thread 1: Acquired Semaphore A")
//    sleep(1)
//    semaphoreB.wait()
//    print("Thread 1: Acquired Semaphore B")
//    semaphoreB.signal()
//    semaphoreA.signal()
//}
//
//DispatchQueue.global().async {
//    semaphoreB.wait()
//    print("Thread 2: Acquired Semaphore B")
//    sleep(1)
//    semaphoreA.wait()
//    print("Thread 2: Acquired Semaphore A")
//    semaphoreA.signal()
//    semaphoreB.signal()
//}
//
//// Output: (The program hangs and doesn't print any output)
private let threadSafeCountQueue = DispatchQueue(label: "...", attributes: .concurrent)
private var _count = 0
public var count: Int {
  get {
    return threadSafeCountQueue.sync {
      return _count
    }
  }
  set {
    threadSafeCountQueue.async(flags: .barrier) {
      _count = newValue
    }
  }
}


let concurrentQueue = DispatchQueue(label: "Test", attributes: .concurrent)
let group = DispatchGroup()


for _ in 1...500 {
    concurrentQueue.async(group: group) {
        let newValue = count + 1
        count = newValue
        print(newValue)
    }
}
group.notify(queue: DispatchQueue.global()) {
    print(count)
}
