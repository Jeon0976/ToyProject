import RxSwift
import RxCocoa
import UIKit
import SwiftUI
import PlaygroundSupport

//let disposeBag = DisposeBag()

// 과거의 연산자들들 다시 연산
// 언제 어떻게 과거와 새로운 요소들을 연결할 수 있는지 컨트롤 할 수 있게 해준다.
// repaly
//let hello = PublishSubject<String>()
//let repeating = hello.replayAll()
//// replay 연산자 사용시 반드시 connect 사용
//repeating.connect()
//
//hello.onNext("1")
//hello.onNext("2")
//hello.onNext("3")
//hello.onNext("4")
//
//repeating
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//hello.onNext("5")

//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 5, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(timeSpan: .seconds(2),
//            count: 5, // 최대값
//            scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// buffer 는 array를 방출하는 대신에,
// window 는 observable를 방출함

//let maxObservable =  5
//// 주어진 시간 간격을 두고 주기마다 방출되는 operator
//let makingTime = RxTimeInterval.seconds(5)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimeSource = DispatchSource.makeTimerSource()
//windowTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimeSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimeSource.resume()
//
//window
//    .window(timeSpan: makingTime,
//            count: maxObservable,
//            scheduler: MainScheduler.instance)
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//

//
//
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//
//delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
////delaySource
////    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
////    .subscribe(onNext: {
////        print($0)
////    })
//
//delaySource
//    .delay(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// delaySubscription : 구독을 뒤로 미룬다는 느낌이었다면
// delay는 전체 시퀀스를 뒤로 미룬다.



// replay

// replayAll

//// buffer
//print("--buffer--")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance)
//    .subscribe(onNext:  {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//// buffer 와 비슷함 대신 window는 observable을 방출함 (buffer는 array를 방출함)
//print("--window--")
//
//source
//    .window(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//// delaysubscription
//print("--delaySubscription--")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// delay 는 전체 시퀀스를 뒤로 미는 느낌
// delaySubscription 구독을 미룬다
//
//
//// interval
//// 특정 간격으로 생성
//print("--interval--")
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
////        print($0)
////    })
////    .disposed(by: disposeBag)
//
//// timer
//print("--timer--")
//Observable<Int>
//    .timer(.seconds(5),
//           period: .seconds(2),
//           scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//

//Observable<Int>
//    .timer(.seconds(3),
////           period: .seconds(2),
//           scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//// timeout
//// 임의 종료을 원할 때
//
//
//Observable<Int>
//    .interval(.seconds(1), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//let notButtonTapedError = UIButton(type: .system)
//notButtonTapedError.setTitle("click", for: .normal)
//notButtonTapedError.sizeToFit()
//
//PlaygroundPage.current.liveView = notButtonTapedError
//
//notButtonTapedError.rx.tap
//    .do(onNext: {
//        print("tap")
//    })
//    .timeout(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//
//


//let relay = PublishRelay<Int>()
//let disposeBag = DisposeBag()
//
//relay.accept(1)
//
//relay
//    .subscribe(onNext: {
//        print("첫 번째: ", $0)
//    })
//    .disposed(by: disposeBag)
//
//relay.accept(2)
//
//relay
//    .subscribe(onNext: {
//        print("두 번째:", $0)
//    })
//relay.accept(3)
//relay.accept(4)


struct Student {
    let score: BehaviorSubject<Int>
}

let disposeBag = DisposeBag()

let laura = Student(score: BehaviorSubject(value: 80))
let charlotte = Student(score: BehaviorSubject(value: 90))
let jeon = Student(score: BehaviorSubject(value: 22))
let student = PublishSubject<Student>()

student
    .flatMapLatest {
        $0.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

student.onNext(laura)
laura.score.onNext(85)
student.onNext(charlotte)
charlotte.score.onNext(95)
charlotte.score.onNext(100)
laura.score.onNext(110)
laura.score.onNext(120)
student.onNext(jeon)
charlotte.score.onNext(140)
jeon.score.onNext(20)
