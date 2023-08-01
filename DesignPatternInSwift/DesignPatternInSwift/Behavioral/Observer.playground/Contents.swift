import UIKit

class Person: NSObject {
    @objc dynamic var age: Int = 0
}

let person = Person()

let ageObservation = person.observe(\.age, options: [.new, .old]) { (person, change) in
    print("from \(change.oldValue ?? 0) to \(change.newValue ?? 0)")
}

person.age = 25

ageObservation.invalidate()

protocol Observer: AnyObject {
    var name: String { get }
    func didChage(name: String, from oldValue: String, to newValue: String)
}

protocol Publisher: AnyObject {
    var observers: [Observer] { get }
    func addObserver(name: String)
    func removeObserver(name: String)
}

final class ConcreteObserver: Observer {
    var name = "전성훈"
    
    func didChage(name: String, from oldValue: String, to newValue: String) {
        print("나는 \(self.name) \(name)의 테스트 숫자가 \(oldValue)에서 \(newValue) 으로 변경")
    }
}


final class ConcretePublisher: Publisher {
    var observers: [Observer] = []
    private let publisherName = "Publisher"
    
    var testNum: Int = 0 {
        didSet {
            observers.compactMap { observer in
                observer.didChage(
                    name: self.publisherName,
                    from: "\(oldValue)",
                    to : "\(self.testNum)"
                )
            }
        }
    }
    
    func addObserver(name: String) {
        let observer = ConcreteObserver()
        observer.name = name
        self.observers.append(observer)
    }
    
    func removeObserver(name: String) {
        observers = self.observers.filter { $0.name != name }
    }
}

let publiser = ConcretePublisher()
publiser.addObserver(name: "홍길동")
publiser.addObserver(name: "전성훈")
publiser.testNum = 40
