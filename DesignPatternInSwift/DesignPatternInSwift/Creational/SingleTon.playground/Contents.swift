import UIKit

var greeting = "Hello, playground"

enum Milk {
    case chocolate
    case strawberry
    case banana
}

// Singleton
class MilkStorage {
    static let shared = MilkStorage()
    
    private var chocoloateMilkCount = 100
    private var strawberryMilkCount = 100
    private var bananaMilkCount = 100
    
    private init() { }
    
    func release(_ milk: Milk, count: Int) {
        switch milk {
        case .chocolate:
            chocoloateMilkCount -= count
        case .strawberry:
            strawberryMilkCount -= count
        case .banana:
            bananaMilkCount -= count
        }
    }
    
    func checkMilkCount() {
        print("""
            - 남은 재고 -
             1. 초코 우유: \(chocoloateMilkCount)
             2. 딸기 우유: \(strawberryMilkCount)
             3. 바나나 우유: \(bananaMilkCount)
            """)
    }
}


class OnlineStore {
    func orderMilk(_ milk: Milk, count: Int) {
        MilkStorage.shared.release(milk, count: count)
    }
}

let naverSmartStore = OnlineStore()
let coupang = OnlineStore()
let weMakePrice = OnlineStore()

naverSmartStore.orderMilk(.banana, count: 15)

MilkStorage.shared.checkMilkCount()
