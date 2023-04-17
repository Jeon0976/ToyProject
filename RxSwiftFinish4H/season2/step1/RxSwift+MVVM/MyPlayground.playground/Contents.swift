import UIKit
import RxSwift

let testObservable = Observable<String>.create { observer in
    print("Observable - \(Thread.current)")
    observer.onNext("test 1")
    observer.onNext("test 2")
    
    observer.onCompleted()
    
    return Disposables.create()
}


testObservable
    .map({str in
        print("map \(str) Thread: \(Thread.current)")
        return str.filter { !$0.isNumber }
    })
    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    .map({str in
        print("map \(str) Thread: \(Thread.current)")
        return str.uppercased()
    })
    .observeOn(MainScheduler.instance)

    .subscribe(onNext: { str in
        print("onNext - String: \(str)   Thread : \(Thread.current)")
    }, onError: nil,
               onCompleted: {
        print("onCompleted - Thread : \(Thread.current)")
    })


extension ObservableType {
    func addSchedulers() -> Self {
        return self
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance) as! Self
    }
}

testObservable
    .addSchedulers()
    .subscribe()
