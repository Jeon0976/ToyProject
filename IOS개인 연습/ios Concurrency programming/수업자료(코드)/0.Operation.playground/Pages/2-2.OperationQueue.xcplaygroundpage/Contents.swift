//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 오퍼레이션큐(OperationQueue)
//: ### 오퍼레이션을 스케줄링, 실행하고 관리하는 큐(다양한 기능이 있는 큐)

//: ## 오퍼레이션큐 만들기
//: 간단하게 클로저를 더할 수 있는 오퍼레이션큐 만들기
// 오퍼레이션큐 생성
let printerQueue = OperationQueue()


// 사용할 최대의 쓰레드 갯수를 정의(기본설정은 -1)
// 1로 설정하면 시리얼로 사용
printerQueue.maxConcurrentOperationCount = 2


// 간단한 클로저를 오퍼레이션 큐에 더하기 (더하면, 바로 작업이 비동기적으로 시작됨)
// 주로 "오퍼레이션"을 "오퍼레이션큐"에 넣어서 작업을 실행시키겠지만, 아래처럼 단순히 클로저를 넣는 것도 가능
//timeCheck {
//printerQueue.addOperation { print("Hello,"); sleep(3) }
//printerQueue.addOperation { print("This"); sleep(3) }
//printerQueue.addOperation { print("is"); sleep(3) }
//printerQueue.addOperation { print("Operation"); sleep(3) }
//printerQueue.addOperation { print("Class"); sleep(3) }
//}



// 동기적으로 모든 오퍼레이션큐 안의 작업을 완료할때까지 기다리기 위한 함수
// (실제 앱에선 메인스레드에서 실행하면 절대 안됨)
//timeCheck {
//printerQueue.waitUntilAllOperationsAreFinished()
//}



//: ## 오퍼레이션큐의 설정
// 참고==================================
printerQueue.qualityOfService = .utility

printerQueue.underlyingQueue = .global()

let op = Operation()
op.qualityOfService = .utility
// =====================================




//: ## 일반적인 오퍼레이션과 오퍼레이션큐의 사용
//: 이미지배열을 필터를 적용해서 변형해보고, 펄터 적용된 다른 배열 만들어 보기
let images = ["city", "dark_road", "train_day", "train_dusk", "train_night"].map { UIImage(named: "\($0).jpg") }

// 필터된 이미지 저장할 배열 (동시성 문제 발생할 수 있으니 주의)
var filteredImages = [UIImage]()

//: 1. Step1: 사용할 오퍼레이션 큐들을 생성하기
// 필터(이미지변형)오퍼레이션들을 넣을 오퍼레이션큐
let filterQueue = OperationQueue()

// 동시성 문제를 없애기 위한 또다른 직렬큐
let appendQueue = OperationQueue()
appendQueue.maxConcurrentOperationCount = 1


// 🔸배열은 밸류타입(value-type)이고 값을 복사해서 사용하기 때문에 문제가 안 발생할 수 있지만,
// 특히 클래스 객체 내의 속성으로 가지고 있는 배열일때, 문제가 발생한다는 리포트들이 있음🔸

//: 2. Step2: 실제 오퍼레이션생성해서 오퍼레이션 큐에 넣기
for image in images {
  // 각각의 이미지를 필터링하는 작업이 "각 1개의 오퍼레이션"임.
  let filterOp = TiltShiftOperation()
  filterOp.inputImage = image
    
  // 오퍼레이션이 완료되면, "appendQueue"로 보내서 배열에 append할 수있도록 함.
  filterOp.completionBlock = {
    guard let output = filterOp.outputImage else { return }
    appendQueue.addOperation {
      filteredImages.append(output)
    }
  }
    
  // 이제 이렇게 만든 작업을, 실제 "filterQueue" 넣기
  filterQueue.addOperation(filterOp)
}

//: 3. Step3: 실제 변형 배열 결과 확인하기
// 여기서 확인하면 안됨
// filteredImages


sleep(1)


// 참고==================================
//filterQueue.isSuspended = true
//filterQueue.isSuspended = false
//======================================


// 모든 이미지 변형이 끝날때까지 기다리기

filterQueue.waitUntilAllOperationsAreFinished()






// 배열확인해 보기
filteredImages


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
