//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 오퍼레이션(Operation)
//: ### 기본 오퍼레이션 만들기

//: 1. 추상 Operation 클래스를 상속해서, Operation 클래스 만들기
//: - (1)input 변수 정의  (2) output 변수 정의  (3) main()를 재정의가 필요함
// 이미지 변형(tiltShift)하는 기본 오퍼레이션 만들기
class TiltShiftOperation: Operation {
  var inputImage: UIImage?
  var outputImage: UIImage?
  
  // 기본적으로 실행할 함수는 main() 안에 배치
  override func main() {
    // 함수는 TiltShift.swift에 정의
    outputImage = tiltShift(image: inputImage)
  }
}


//: 2. 인스턴스화 해서, 오퍼레이션 사용하기
let inputImage = UIImage(named: "dark_road.jpg")


// 오퍼레이션을 인스턴스화 (오퍼레이션은 기본적으로 한번만 실행할 수있는 Single-shot 객체)
let tsOp = TiltShiftOperation()
tsOp.inputImage = inputImage
tsOp.isReady
tsOp.isExecuting
tsOp.isFinished

// 오퍼레이션큐에 넣지않고도, start()메서드로 실행 시작가능 (기본 동기적으로 동작)
timeCheck {
    tsOp.start()
    tsOp.isReady
    tsOp.isExecuting
    tsOp.isFinished

}

tsOp.outputImage



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
