import Foundation

protocol Prototype: AnyObject {
    func clone() -> Self
}

class Dog: Prototype {
    var age: Int
    
    init(age: Int) {
        self.age = age
    }
    
    func clone() -> Self {
        return Dog(age: self.age) as! Self
    }
}

let testDog = Dog(age: 1)
testDog.age += 2
let test2Dog = testDog.clone()

testDog.age += 3

print(test2Dog.age)
print(testDog.age)

class PrototypeTest: NSCopying {
    var num: Int
    
    init(num: Int) {
        self.num = num
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = PrototypeTest(num: num)
        return copy
    }
}


let testPro = PrototypeTest(num: 2)

if let copy = testPro.copy() as? PrototypeTest {
    print(copy.num)
}
