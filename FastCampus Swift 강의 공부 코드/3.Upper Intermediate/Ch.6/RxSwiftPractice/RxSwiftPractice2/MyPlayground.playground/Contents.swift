import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

Observable.of("A","B","C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)


let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

Observable<Int>.of(123, 4, 66)
    .map{
        formatter.string(for: $0) ?? ""
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


Observable.of("To", "Be", nil, "or", "not", "to", "be", nil)
    .compactMap { $0 }
    .toArray()
    .map{ $0.joined(separator: " ") }
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

struct Student {
    let score: BehaviorSubject<Int>
}


let laura = Student(score: BehaviorSubject(value: 80))
let charlotte = Student(score: BehaviorSubject(value: 90))

let student = PublishSubject<Student>()

student
    .flatMap {
        $0.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

student
    .flatMapLatest{
        $0.score
    }
    .subscribe(onNext: {
        print("flatMapLatest: \($0)")
    })
    .disposed(by: disposeBag)

student.onNext(laura)
laura.score.onNext(85)
student.onNext(charlotte)
charlotte.score.onNext(95)
charlotte.score.onNext(100)
laura.score.onNext(110)

let observable1 = Observable.of("A","B","C")
let observable2 = Observable.of("a","b","c")
let observable3 = Observable.of("1","2","3")
observable1
    .flatMap { observable1 -> Observable<String> in
        return observable2.map{observable1 + $0}
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
observable1
    .flatMapLatest{ observable1 -> Observable<String> in
        return observable2.map{observable1 + $0}
    }
    .subscribe(onNext: {
        print("flatMapLatest: \($0)")
    })
    .disposed(by: disposeBag)

Observable
    .merge(
    observable1,
    observable2,
    observable3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
