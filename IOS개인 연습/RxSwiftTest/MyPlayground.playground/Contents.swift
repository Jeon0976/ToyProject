import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let test = Observable.just(dofunc())

func dofunc() {
    print(1+1)
}

let test2 = PublishSubject<Any>()

test2.onNext(dofunc())

//test.subscribe {
//    print($0)
//}

//let observable = Observable.from([1,2,3])
//observable.bind(onNext: { int in
//    let value = int+5
//    print(value)
//})
//
//observable.subscribe(onNext: {
//    print($0)
//})

//let relay = PublishRelay<Int>()
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
//        print("두 번째: ", $0)
//    })
//relay.accept(3)
//relay.accept(4)


//let subjcet = ReplaySubject<String>.create(bufferSize: 2)
//
//subjcet.onNext("1")
//
//subjcet
//    .subscribe {
//        print("첫번째 구독자: ", $0)
//    }
//
//subjcet.onNext("2")
//subjcet.onNext("3")
//
//subjcet
//    .subscribe {
//        print("두번째 구독자: ", $0)
//    }
//
//subjcet.onNext("4")
//subjcet.onCompleted()


//class UserViewModel {
//    let name = BehaviorSubject<String>(value: "John Doe")
//
//    func updateName(newName: String) {
//        name.onNext(newName)
//    }
//}
//
//class UserProfileViewController: UIViewController {
//    let disposeBag = DisposeBag()
//    let viewModel = UserViewModel()
//    let nameLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        viewModel.name
//            .subscribe(onNext: { [weak self] name in
//                self?.nameLabel.text = name
//            })
//            .disposed(by: disposeBag)
//    }
//}
//

//let subject = BehaviorSubject(value: "초기 값")
//
//subject
//    .subscribe{
//        print("첫번째 구독자: ", $0)
//    }
//    .disposed(by: disposeBag)
//
//subject.onNext("1")
//
//subject
//    .subscribe {
//        print("두번째 구독자: ", $0)
//    }
//
//subject.onNext("2")
//subject.onNext("3")
//subject.onCompleted()


//
//let subject = PublishSubject<String>()
//
//subject.onNext("1")
//
//let subscriptionOne = subject
//    .subscribe(onNext: { string in
//        print("첫번째", string)
//    })
//
//subject.onNext("2")
//
//let subscriptionTwo = subject
//    .subscribe(onNext: { string in
//        print("두번째", string)
//    })
//
//subject.onNext("3")
//
//subscriptionOne.dispose()
//subscriptionTwo.dispose()
//subject.onCompleted()
//
//// 첫번째 2
// 첫번째 3
// 두번째 3


class UserViewModel {
    let name = PublishSubject<String>()

    func updateName(newName: String) {
        name.onNext(newName)
    }
}

class UserViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = UserViewModel()
    let nameLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

