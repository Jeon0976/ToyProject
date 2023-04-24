import RxSwift

let disposeBag = DisposeBag()

let roomTemperature = PublishSubject<Int>()

// Start emitting temperature updates
roomTemperature.onNext(65)
roomTemperature.onNext(66)

// subscribe to temperature updates
let subscription1 = roomTemperature.subscribe(onNext: {
  print("Subscription 1: \($0)°F")
})

roomTemperature.onNext(67)
roomTemperature.onNext(68)

// subscribe to temperature updates
let subscription2 = roomTemperature.subscribe(onNext: {
  print("Subscription 2: \($0)°F")
})

roomTemperature.onNext(69)
roomTemperature.onCompleted()

let test = Observable<Int>.create { observer in
    observer.onNext(Int.random(in: 0...10))

    return Disposables.create()
}.subscribe(<#T##observer: ObserverType##ObserverType#>)

test.subscribe { event in
    print(event)
}
