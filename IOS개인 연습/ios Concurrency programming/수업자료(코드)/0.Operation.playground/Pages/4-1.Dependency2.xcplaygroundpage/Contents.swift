//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 프로토콜을 설정 안한 경우 예시
//: ### 프로토콜을 설정하지 않는 경우(데이터 전달 오퍼레이션이 필요함)

//: 이미지 다운로드하는 첫번째 (비동기)오퍼레이션 정의
// (1) 이미지 다운로드하는 비동기 오퍼레이션
class ImageLoadOperation: AsyncOperation {
    var inputName: String?
    var outputImage: UIImage?
    
    override func main() {
        // 이 메서드는 잠깐 sleep했다가 이미지를 반환하는 시뮬레이팅 메서드임.
        simulateAsyncNetworkLoadImage(named: self.inputName) {
            [unowned self] (image) in
            self.outputImage = image
            self.state = .finished
        }
    }
}


//: 이미지변형하는 두번째 오퍼레이션 정의
// 이미지 변형하는 오퍼레이션
class TiltShiftOperation1: Operation {
    var inputImage: UIImage?
    var outputImage: UIImage?
    
    override func main() {
        guard let inputImage = inputImage else { return }
        outputImage = tiltShift(image: inputImage)
    }
}


//: 오퍼레이션 생성
let imageLoad = ImageLoadOperation()
let filter = TiltShiftOperation1()

// 간단하게 데이터를 전달하는 오퍼레이션이기에 ===> 블락오퍼레이션으로 생성가능
let dataTransfer = BlockOperation {
    filter.inputImage = imageLoad.outputImage
}

imageLoad.inputName = "train_day.jpg"


//: 의존성 설정 2개 해야함
// 의존성 설정 "dataTransfer오퍼레이션"이 "imageLoad오퍼레이션"에 의존한다.
dataTransfer.addDependency(imageLoad)
// 의존성 설정 "filter오퍼레이션"이 "dataTransfer오퍼레이션"에 의존한다.
filter.addDependency(dataTransfer)



//: 3개의 오퍼레이션을 오퍼레이션큐에 넣어서 진행 확인
let queue = OperationQueue()

// 큐에 오퍼레이션 넣기 (동기적으로 기다리게 해서 확인해보기)
//timeCheck {
queue.addOperations([imageLoad, dataTransfer, filter], waitUntilFinished: true)
//}


imageLoad.outputImage
filter.outputImage



sleep(3)
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
