import RxSwift
let disposeBag = DisposeBag()

// 1
//let formatter = NumberFormatter()
//formatter.numberStyle = .spellOut
//
//// 2
//Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
//// 3
//    .distinctUntilChanged({ a, b in
//        //4
//        guard let aWords = formatter.string(from: a)?.components(separatedBy: " "),
//              let bWords = formatter.string(from: b)?.components(separatedBy: " ") else {return false}
//
//        var containsMatch = false
//
//        // 5
//        for aWord in aWords {
//            print("a: ",aWord)
//            for bWord in bWords {
//                if aWord == bWord {
////                    print(aWord)
//                    print(bWord)
//                    containsMatch = true
//                    break
//                }
//            }
//        }
//
//        return containsMatch
//    })
//// 6
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//let ex: NSNumber = 110
//
//let aw = formatter.string(from: ex)

//
//let strikes = PublishSubject<String>()
//
//strikes
//    .ignoreElements()
//    .subscribe { _ in
//        print("Out!!")
//    }
//    .disposed(by: disposeBag)
//strikes.onNext("X")
//strikes.onNext("X")
//strikes.onNext("X")
//strikes.onCompleted()
//
//let strikesTwo = PublishSubject<String>()
//
//strikesTwo
//    .element(at: 2)
//    .subscribe(onNext: { _ in
//        print("Out!")
//    })
//    .disposed(by: disposeBag)
//
//strikesTwo.onNext("X")
//strikesTwo.onNext("X")
//strikesTwo.onNext("X")
//
//Observable.of(1,2,3,4,5,6,7)
//    .filter { $0.isMultiple(of: 2)}
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//Observable.of("A","B","C","D","E","F")
//    .skip(3)
//    .subscribe (onNext:{
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//
//Observable.of(2,4,3,4)
//    .skip(while: {$0.isMultiple(of: 2)})
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//
//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject
//    .skip(until: trigger)
//    .subscribe(onNext:  {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//trigger.onNext("X")
//subject.onNext("C")


Observable.of(2,2,3,4,4,6,6)
    .enumerated()

    .take(while: { index, integer in
        integer.isMultiple(of: 2) && index < 4
    })
    .map(\.element)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


// 1
Observable.of(1, 2, 3, 4, 5)
// 2
    .takeUntil(.inclusive) { $0.isMultiple(of: 4) }
    .subscribe(onNext: {
        print($0) })
    .disposed(by: disposeBag)


// 1
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()
// 2
subject
    .take(until: trigger)
    .subscribe(onNext: {
        print($0) })
    .disposed(by: disposeBag)
// 3
subject.onNext("1")
subject.onNext("2")
trigger.onNext("X")
subject.onNext("3")
