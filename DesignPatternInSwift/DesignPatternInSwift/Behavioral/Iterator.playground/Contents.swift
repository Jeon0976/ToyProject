import UIKit

// Iterator 패턴 rngus
struct Food {
    let name: String
}

struct Foods {
    let foods: [Food]
}

struct FoodsIterator: IteratorProtocol {
    private var current = 0
    private let foods: [Food]
    
    init(foods: [Food]) {
        self.foods = foods
    }
    
    mutating func next() -> Food? {
        defer { current += 1 }
        return foods.count > current ? foods[current] : nil
    }
}

extension Foods: Sequence {
    func makeIterator() -> FoodsIterator {
        return FoodsIterator(foods: foods)
    }
}

// Iterator 사용 - Client
let favortieFoods = Foods(foods: [
    Food(name: "Test"),
    Food(name: "gg")
])

for food in favortieFoods {
    print(food)
}

