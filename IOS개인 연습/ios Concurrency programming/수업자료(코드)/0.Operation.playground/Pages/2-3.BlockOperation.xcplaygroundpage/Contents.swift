//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 블락오퍼레이션(BlockOperation)
//: ### 내부에 block(closure)들을 내장하고 있는 오퍼레이션

//: 블락오퍼레이션 생성하고 실행해보기
var result: Int?

// 블락오퍼레이션의 생성하기
let summationOperation = BlockOperation {
    result = 2 + 3
    sleep(3)
}

// 블락오퍼레이션의 시작 (내부의 block들은 concurrent하게 동작하지만, 감싸고 있는 오퍼레이션 자체는 동기적으로 동작)
//timeCheck {
summationOperation.start()
//}

result


//: Create a `BlockOperation` with multiple blocks:
// 블락오퍼레이션 생성하기
let multiPrinter = BlockOperation()


multiPrinter.completionBlock = {
    print("===모든 출력의 완료!===")
}

// 순서대로 출력되지 않는다.
multiPrinter.addExecutionBlock {  print("Hello,"); sleep(2) }
multiPrinter.addExecutionBlock {  print("This"); sleep(2) }
multiPrinter.addExecutionBlock {  print("is"); sleep(2) }
multiPrinter.addExecutionBlock {  print("Operation"); sleep(2) }
multiPrinter.addExecutionBlock {  print("Class"); sleep(2) }


// 기본적으로는 동기적인 실행

//timeCheck {
multiPrinter.start()
//}





// 다른 큐로 보내면 =============> 이미 한번 실행해서 없어진 객체이기 때문에 2번의 실행은 안됨.

// 비동기적인 블락오퍼레이션의 실행

let queue = OperationQueue()

queue.maxConcurrentOperationCount = 1

timeCheck {
    queue.addOperation(multiPrinter)
}


PlaygroundPage.current.finishExecution()
//: [Next](@next)
