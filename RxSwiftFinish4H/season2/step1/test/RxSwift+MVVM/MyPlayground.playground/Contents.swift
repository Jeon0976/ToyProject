import UIKit
import RxSwift


let test = Observable<Int>.create { observer in
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    
    return Disposables.create()
}

test.subscribe { event in
    switch event {
    case .next(let data) :
        print(data)
        break
    case .completed:
        break
    case .error(_):
        break
    }
}
