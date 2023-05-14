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

// "Thread-safe"한 Number 클래스
// Thread-safe하게 만들기: 동시큐와 디스패치 배리어를 사용.
class Number {
    var value: Int
    var name: String
    
    let concurrentQueue = DispatchQueue(label: "com.raywenderlich.number.isolation", attributes: .concurrent)
    
    init(value: Int, name: String) {
        self.value = value
        self.name = name
    }
    
    // 🎾 쓰기(write)작업 - 배리어처리(동시큐지만, 순서적이면서, 다른 쓰레드에서 일을 못하게 막고 작업)
    // 작업을 보내는 쓰레드에서 기다리지는 않음(async)
    func changeNumber(_ value: Int, name: String) {
        concurrentQueue.async(flags: .barrier, execute: {
            randomDelay(0.1)
            self.value = value
            randomDelay(0.5)
            self.name = name
            // 🎾 프린트 제대로 하는 객체를 설계하고 싶다면
//            print("프린트 하고싶다면: \(self.value) :: \(self.name)")
        })
    }
    
    // 🎾 읽기(read)작업은 동시적으로, 보내는 쓰레드에서 기다리도록
    var number: String {
        concurrentQueue.sync {
            return "\(self.value) :: \(self.name)"
        }
    }
}

// Not thread-safe
//class Number {
//  var value: Int
//  var name: String
//
//  init(value: Int, name: String) {
//    self.value = value
//    self.name = name
//  }
//
//  func changeNumber(_ value: Int, name: String) {
//    randomDelay(0.1)
//    self.value = value
//    randomDelay(0.5)
//    self.name = name
//  }
//
//  var number: String {
//    return "\(value) :: \(name)"
//  }
//
//}
