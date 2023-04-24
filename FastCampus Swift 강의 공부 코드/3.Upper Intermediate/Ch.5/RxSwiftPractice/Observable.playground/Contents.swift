import Foundation
import RxSwift

print("----Just----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("----Of----")
Observable<Int>.of(1,2,3,4,5)
    .subscribe(onNext: {
        print($0)
    })
print("----Of2----")
Observable.of([1,2,3,4,5])
// Observable.just([1,2,3,4,5])
    .subscribe(onNext: {
        print($0)
    })
print("----From----")
// array만 받음
// 자동적으로 array 속에 있는 각 각의 요소를 하나씩 방출
Observable.from([1,2,3,4,5])
    .subscribe(onNext: {
        print($0)
    })

print("----subscribe1")
Observable.of(1,2,3)
    .subscribe {
        print($0)
    }

print("----subscribe2")
Observable.of(1,2,3)
    .subscribe{
        if let element = $0.element {
            print(element)
        }
    }

print("----subscribe3")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })

print("----empty")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("----never")
Observable.never()
    .debug("never")
    .subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("Completed")
    })

print("----range")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0) = \(2*$0)")
    })

print("----dispose")
// 아래 요소가 3개 뿐이라서 dispose를 선언하지 않아도 completed가 실행됨 하지만 요소가 무한이면 completed가 실행되지 않음 그래서 dispose를 사용함으로서 complete를 할 수 있게 해줌
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("----disposeBag")

let disposeBag = DisposeBag()

Observable.of(1,2,3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

print("----create1")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onNext("Dwd")
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----create2")
enum MyError : Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(onNext: {print($0)}
           , onError: {print($0.localizedDescription)}
           , onCompleted: {print("Completed") }
           , onDisposed: {print("Disposed") } )
.disposed(by: disposeBag)

// Observable Factory를 만드는 방식
print("----deffered1")
Observable.deferred {
    Observable.of(1,2,3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----deffered2")
var 뒤집기 : Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("🫴")
    } else {
        return Observable.of("🫳")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}



