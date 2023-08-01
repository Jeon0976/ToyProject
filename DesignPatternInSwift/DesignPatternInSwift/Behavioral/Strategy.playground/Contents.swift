import UIKit

// Strategy Interface
protocol SortingStrategy {
    func sort(_ array: [Int]) -> [Int]
}

// Concrete Strategies
class BubbleSortStrategy: SortingStrategy {
    func sort(_ array: [Int]) -> [Int] {
        var arr = array
        // ...
        return arr
    }
}


class QuickSortStrategy: SortingStrategy {
    func sort(_ array: [Int]) -> [Int] {
        var arr = array
        // ...
        return arr
    }
}

// Context
class Context {
    private var strategy: SortingStrategy
    
    init(strategy: SortingStrategy) {
        self.strategy = strategy
    }
    
    func sort(_ array:[Int]) -> [Int] {
        return strategy.sort(array)
    }
    
    func changeStrategy(strategy: SortingStrategy) {
        self.strategy = strategy
    }
}


protocol Strategy {
    func 길찾기()
}

class Car: Strategy {
    func 길찾기() {
        print("자동차 경로를 탐색합니다.")
    }
}

class PublicTransport: Strategy {
    func 길찾기() {
        print("대중교통 경로를 탐색합니다.")
    }
}

class Walk: Strategy {
    func 길찾기() {
        print("도보 경로를 탐색합니다.")
    }
}

class Bicycle: Strategy {
    func 길찾기() {
        print("자전거 경로를 탐색합니다.")
    }
}

class 지도앱 {
    private var strategy: Strategy = PublicTransport()

    init() {
        print("지도앱 서비스를 시작합니다.\\n")
    }

    func 전략설정(to strategy: Strategy) {
        self.strategy = strategy
    }

    func 길찾기() {
        strategy.길찾기()
    }
}

