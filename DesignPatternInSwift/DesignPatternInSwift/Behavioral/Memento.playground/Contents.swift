import UIKit

// Originator
class Originator {
    private var age: Int
    
    init(age: Int) {
        self.age = age
    }
    
    func setAge(to number: Int) {
        age = number
    }
    
    func getAge() -> Int {
        return age
    }
    
    func createMemento() -> Memento {
        return Memento(originator: self)
    }
    
    func checkAge() {
       print(age)
    }
    
}

// Memento
class Memento {
    private let originator: Originator
    private let age: Int
    
    init(originator: Originator) {
        self.originator = originator
        age = originator.getAge()
    }
    
    func restore() {
        print("age 변화")
        originator.setAge(to: age)
    }
}

// Caretaker
class Caretaker {
    private var mementoList = [Memento]()
    
    func saveMemento(using memento: Memento) {
        mementoList.append(memento)
    }
    
    func restoreLast() {
        if let lastState = mementoList.popLast() {
            lastState.restore()
        } else {
            print("last error ")
        }
    }
    
    func restoreSpecificState(index index: Int) {
        if index >= 0 && index < mementoList.count {
            return mementoList[index].restore()
        } else {
            print("out of range")
        }
    }
}


let originator = Originator(age: 21)
let caretaker = Caretaker()

caretaker.saveMemento(using: originator.createMemento())

originator.setAge(to: 22)
originator.setAge(to: 24)
caretaker.saveMemento(using: originator.createMemento())


originator.setAge(to: 25)
originator.checkAge()

caretaker.restoreSpecificState(index: 0)
originator.checkAge()
