//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 동기함수를 비동기함수로 만들기
//: 동기(적)함수 `tiltShift(image:)`를 비동기 함수로 변형해서 활용하는 예제

let image = UIImage(named: "dark_road_small.jpg")


//: (오래걸리는) 이미지를 변형하는 (동기)함수의 예제
// 함수는 TiltShift.swift에 정의 되어있음
// 이미지를 변형시키는 작업은 네트워크 작업이 아니더라도 상당시간 걸림
//timeCheck {
let _ = tiltShift(image: image)
//}



//: (동기 함수를 변형해서) 비동기 함수(`asyncTiltShift`)의 구현
// 동기적 함수를 비동기적 함수로 바꿔서 지속적으로 사용할 수 있도록 만들기
// 결국 (기존 함수의 내용 +)
// 1) 직접적으로 작업을 실행할 큐와
// 2) 작업을 마치고나서의 큐
// 3) 컴플리션핸들러 필요
// 4) 에러처리에 대한 내용

func asyncTiltShift(_ inputImage: UIImage?, runQueue: DispatchQueue, completionQueue: DispatchQueue, completion: @escaping (UIImage?, Error?) -> ()) {
    
    runQueue.async {
        var error: Error?
        error = .none
        
        let outputImage = tiltShift(image: inputImage)
        
        completionQueue.async {
            completion(outputImage, error)
        }
    }
}



//: 일을 하도록 시킬 큐와, 일을 마치고나서 실행 시킬 큐를 정의
let workingQueue = DispatchQueue(label: "com.inflearn.serial")

let resultQueue = DispatchQueue.global()    // 플레이그라운드에서는 메인큐가 아닌 디폴트글로벌큐에서 동작




//: 새롭게 구현한 비동기 함수를 사용해 보기
print("==== 비동기함수의 작업 시작 ====")


asyncTiltShift(image, runQueue: workingQueue, completionQueue: resultQueue) { image, error in
    image
    print("★★★비동기작업의 실제 종료시점★★★")
    //    PlaygroundPage.current.finishExecution()     //실제 모든 작업이 끝나고 플레이그라운드 종료하기 위함
}





print("==== 비동기함수의 작업 끝 ====")





//: # 활용예제
//: 비동기함수와 for문 결합해서 유사한 작업에 활용해보기
//:

let imageNames = ["dark_road_small", "train_day", "train_dusk", "train_night"]
let images = imageNames.compactMap { UIImage(named: "\($0).jpg") }
images


// 변형한 이미지 저장하기 위한 배열 생성
var tiltShiftedImages = [UIImage]()

// 동시큐 만들기
let workerQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)


let appendQueue = DispatchQueue(label: "com.inflearn.append.serial")


//timeCheck {
for image in images {
    asyncTiltShift(image, runQueue: workerQueue, completionQueue: appendQueue) { image, error in
        guard let image = image else { return }
        tiltShiftedImages.append(image)
    }
}
//}


sleep(5)
tiltShiftedImages




PlaygroundPage.current.finishExecution()

//: [Next](@next)
