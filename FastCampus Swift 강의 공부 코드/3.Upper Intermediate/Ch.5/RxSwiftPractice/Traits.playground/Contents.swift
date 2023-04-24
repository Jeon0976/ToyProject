import RxSwift

let disposeBag = DisposeBag()

enum TraitsError : Error {
    case single
    case maybe
    case completable
}

print("--single1")
Single<String>.just("✔︎")
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0)")
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)

print("--single2")
Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.single)
    return Disposables.create()
}
    .asSingle()
    .subscribe (
        onSuccess:  {
            print($0)
        } ,onFailure: {
            print("error: \($0.localizedDescription)")
        } ,onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)

struct SomeJSON : Decodable {
    let name : String
}

enum JSONError : Error {
    case decodingError
}

let json1 = """
    {"name":"Jeon"}
    """
let json2 = """
    {"my_name":"SeongHun"}
    """

func decode(json :String) -> Single<SomeJSON> {
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self, from: data) else { observer(.failure(JSONError.decodingError))
            return Disposables.create() }
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
    .subscribe {
        switch $0 {
        case .success(let json) :
            print(json.name)
        case.failure(let error) :
            print(error)
        }
    }
    .disposed(by: disposeBag)

decode(json: json2)
    .subscribe {
        switch $0 {
        case .success(let json) :
            print(json.name)
        case.failure(let error) :
            print(error)
        }
    }
    .disposed(by: disposeBag)

//
//let disposeBag = DisposeBag()
//let one = 1
//let two = 2
//let three = 3
//
//let observable:Observable<Int> = Observable<Int>.just(one)
//
//let observable2 = Observable.of(one,two,three)
//let observable22 = Observable.of([one,two,three])
//let observable3 = Observable.from([one,two,three])
//observable.subscribe { event in
//    print(event)
//}
//
//observable2.subscribe { event in
//    print(event)
//}
//observable3.subscribe { event in
//    print(event)
//}
//
//observable3.subscribe(onNext: { element in
//    print(element)
//})
//
//let observableEmpty = Observable<Void>.empty()
//
//observableEmpty.subscribe(
//    onNext: { element in
//        print(element)
//    },
//
//    onCompleted: {
//        print("Completed")
//    }
//
//).disposed(by: disposeBag)
//let observableRange = Observable<Int>.range(start: 1, count: 10)
//observableRange.subscribe(onNext: { i in
//      let n = Double(i)
//      let fibonacci = Int(
//        ((pow(1.61803, n) - pow(0.61803, n)) /
//          2.23606).rounded()
//      )
//      print(fibonacci)
//}).disposed(by: disposeBag)
//
//Observable<String>.create { observer in
//    observer.onNext("1")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//}.subscribe(
//    onNext: { print($0)},
//    onError: { print($0)},
//    onCompleted: {print("Completed")},
//    onDisposed: {print("Disposed")}
//).disposed(by: DisposeBag())
