import RxSwift

let disposeBag = DisposeBag()

//let numbers = Observable.of(2,3,4)
//
//numbers
//    .startWith(1)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)

let CConcat: () = Observable.concat([first,second])
    .subscribe(onNext: {
        print("concat:\($0)")
    })
    .disposed(by: disposeBag)
let MMerge: () = Observable.merge(first,second)
    .subscribe(onNext: {
        print("merge:\($0)")
    })
    .disposed(by: disposeBag)

let sequences = [
  "German cities": Observable.of("Berlin", "Münich",
"Frankfurt"),
  "Spanish cities": Observable.of("Madrid", "Barcelona",
"Valencia")
]
// 2
let observable = Observable.of("German cities", "Spanish cities")
  .concatMap { country in sequences[country] ?? .empty() }
// 3
_ = observable.subscribe(onNext: { string in
    print(string)
})
// 현재 상태 초기값이 필요한 상황에서 사용
print("--startWith--")
let yellowClass = Observable<String>.of("김","강","전")

yellowClass
//enumrated : index 와 element 를 분리
    .enumerated()
    .map({ (index, element) in
        return element + "어린이" + "\(index)"
    })
    .startWith("teacher") // String
    .subscribe (onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--concat1---")
let redClass = Observable<String>.of("Kim","Kang","James")
let teacher = Observable<String>.of("Teacher")

let lineWalk = Observable
    .concat([teacher,redClass])

lineWalk
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--concat2--")
teacher
    .concat(redClass)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//flatMap과 비슷
print("--concatMap--")
let house: [String: Observable<String>] = [
    "yellowClass": Observable.of("kim","jeon","kww"),
    "blueClass": Observable.of("sdd","dwd")
]

Observable.of("yellowClass","blueClass")
    .concatMap { Class in
        house[Class] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--merge1--")
let kangBook = Observable.from(["0.강북구","0.성북구","0.동대문구","0.종로구"])
let kangnam = Observable.from(["1.강남구","1.강동구","1.영등포구","1.양천구"])

Observable.of(kangBook,kangnam)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--merge2--")
Observable.of(kangBook,kangnam)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("--combineLatest1--")

let firstName = PublishSubject<String>()
let lastName = PublishSubject<String>()

let name = Observable
    .combineLatest(firstName, lastName) { firstName, lastName in
        firstName + lastName
    }

name
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
firstName.onNext("김")
lastName.onNext("길동")
lastName.onNext("영수")
lastName.onNext("똘똘")
firstName.onNext("박")
firstName.onNext("이")
firstName.onNext("조")


print("--combineLatest2--")
let dateType = Observable<DateFormatter.Style>.of(.short, .long)
let nowDate = Observable<Date>.of(Date())

let nowDateType = Observable
    .combineLatest(
        dateType,
        nowDate, resultSelector: { dateType, nowDate -> String in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = dateType
            return dateFormatter.string(from: nowDate)
        })
nowDate
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--combineLatest3--")
let lastName2 = PublishSubject<String>()
let firstName2 = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName2,lastName2]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName2.onNext("Kim")
firstName2.onNext("Paul")
firstName2.onNext("Stella")
firstName2.onNext("Lily")

print("--zip--")
// 합치는 것들 중 둘 중 하나만이라도 완료되면 종료
enum 승패 {
    case 승
    case 패
}
let 승부 = Observable<승패>.of(.승,.승,.패,.승,.패)
let 선수 = Observable<String>.of("1","2","3","4","5","6")

let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "\(결과)"
    }
시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


// Trigger 성격의 operator
print("--withLatestFrom1--")
let bbang = PublishSubject<Void>()
let runner = PublishSubject<String>()

bbang
    .withLatestFrom(runner)
// withLatestFrom을 sample처럼 사용하기 위해선 distinctUntilChaged() 사용
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

runner.onNext("1")
runner.onNext("2")
runner.onNext("3")
bbang.onNext(Void())
bbang.onNext(Void())


// withLatestFrom과 매우 비슷하지만 딱 한 번만 방출함
print("--sample--")
let start = PublishSubject<Void>()
let F1Payer = PublishSubject<String>()

F1Payer
    .sample(start)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1Payer.onNext("1")
F1Payer.onNext("1, 2")
start.onNext(Void())
start.onNext(Void())

// 일단 두 개 구독하긴 하지만 둘 중 먼저 방출하는 것이 생기면 나머지는 구독을 하지 않는다.
print("--amb--")
let bus1 = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let busStation = bus1.amb(bus2)

busStation
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

bus1.onNext("1-0")
bus2.onNext("2-0")
bus2.onNext("2-1")
bus1.onNext("1-1")
bus1.onNext("1-2")
bus2.onNext("2-2")

print("---switchLatest--")
let student1 = PublishSubject<String>()
let student2 = PublishSubject<String>()
let student3 = PublishSubject<String>()

let handsUp = PublishSubject<Observable<String>>()

let onlyTalkIfHandsUp = handsUp.switchLatest()


onlyTalkIfHandsUp
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

handsUp.onNext(student1)
student1.onNext("하이 헬로우 모두들 안녕~")
student2.onNext("나는 이하뉘다~")
handsUp.onNext(student2)
student2.onNext("나나")
student3.onNext("sddd")

print("--reduce--")
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--scan--")
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// reduce는 리턴시 결과값만 방출하지만 scan은 observable로 계속해서 observable 타입으로 새로운 값이 들어올때마다 새로운 형태로 이벤트들을 내뱉음


enum Weather {
    case cloudy
    case sunny
}

let left : Observable<Weather> = Observable.of(.sunny,.cloudy,.cloudy,.sunny)
let right = Observable.of("Lisbon", "Copenhagen", "London","Madrid", "Vienna")

let test: () = Observable.zip(left, right) { weather, city in
    return "It's \(weather) in \(city)"}
.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)


let ambRight = PublishSubject<String>()
let ambLeft = PublishSubject<String>()


let ambObservable = ambRight.amb(ambLeft)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

ambRight.onNext("Seoul")
ambLeft.onNext("Lisbon")
ambLeft.onNext("London")
ambLeft.onNext("Busan")
ambRight.onNext("Vienna")



let source = Observable.of(1,3,5,7,9)

let reduceObservable: () = source.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print("reduce:\($0)")
    })
    .disposed(by: disposeBag)

let scanObservable: () = source.scan(0, accumulator: +)
    .subscribe(onNext: {
        print("scan:\($0)")
    })
    .disposed(by: disposeBag)


