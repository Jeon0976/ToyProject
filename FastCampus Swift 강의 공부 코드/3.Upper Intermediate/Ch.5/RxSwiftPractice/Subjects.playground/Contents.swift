import RxSwift

let disposaBag = DisposeBag()

print("---publisSubject")
let publishSubject  = PublishSubject<String>()

publishSubject.onNext("안녕!")

let 구독자1 = publishSubject
    .subscribe(onNext: {
        print($0)
    })

publishSubject.onNext("들리시나요?")
//구독자1.dispose()
publishSubject.onNext("안들려요..??")
구독자1.dispose()

let 구독자2 = publishSubject
    .subscribe(onNext: {
        print($0)
    })

publishSubject.onNext("여보세요??")
publishSubject.onCompleted()

publishSubject.onNext("끝!")

구독자2.dispose()

publishSubject
    .subscribe {
        print("세번째 구독 : ", $0.element ?? $0)
    }
    .disposed(by: disposaBag)

publishSubject.onNext("찍힐까?")

enum SubjectError : Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "0.초기값")
behaviorSubject.subscribe {
    print("0번째 구독:", $0.element ?? $0)
}
.disposed(by: disposaBag)


behaviorSubject.onNext("1.첫번째 값")
behaviorSubject.onNext("2.2번째 값")
behaviorSubject.onNext("3.3번째 값")
behaviorSubject.subscribe {
    print("첫번째 구독:", $0.element ?? $0)
}
.disposed(by: disposaBag)

behaviorSubject.onNext("4.4번째 값")
behaviorSubject.onCompleted()
behaviorSubject.onNext("5.5번째 값")

//behaviorSubject.onError(SubjectError.error1)

behaviorSubject.onNext("6.6번째 값")

behaviorSubject.subscribe {
    print("두번째 구독:", $0.element ?? $0)
}
.disposed(by: disposaBag)

let value = try? behaviorSubject.value()
print(value)


let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1")
replaySubject.onNext("2")
replaySubject.onNext("3")

replaySubject.subscribe {
    print("첫번째 구독 :", $0.element ?? $0)
}
.disposed(by: disposaBag)

replaySubject.subscribe {
    print("두번째 구독 :", $0.element ?? $0)
}
.disposed(by: disposaBag)

replaySubject.onNext("4")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세번째 구독 :", $0.element ?? $0)
}
.disposed(by: disposaBag)

