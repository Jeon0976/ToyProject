import UIKit

// Mediator
protocol Mediator {
    func notify(sender: Component, price: Int)
}

// Component
protocol Component {
    var mediator: Mediator? { get set }
}

// Concrete Component
class Seller: Component {
    var mediator: Mediator?
    
    var isSold: Bool = false
    
    func sell(price: Int) {
        print("판매자: 그 가격에 거래할게요.")
        
        mediator?.notify(sender: self, price: price)
    }
}

class Buyer: Component {
    var mediator: Mediator?
    
    var money: Int = 50000
    
    func buy() {
        print("구매자: \(money)원에 살게요.")
        self.mediator?.notify(sender: self, price: money)
    }
    
    func deposit(price: Int) {
        print("구매자: \(price)원 입금했습니다.")
        money -= price
    }
}

// Concrete Mediator
class Broker: Mediator {
    private let seller: Seller
    private let buyer: Buyer
    
    func notify(sender: Component, price: Int) {
        if sender is Buyer {
            seller.sell(price: price)
        }
        
        if sender is Seller {
            buyer.deposit(price: price)
            print("거래 성사")
        }
    }
    
    init(seller: Seller, buyer: Buyer) {
        self.seller = seller
        self.buyer = buyer
        seller.mediator = self
        buyer.mediator = self
    }
}

let seller = Seller()
let buyer = Buyer()

let broker = Broker(seller: seller, buyer: buyer)
buyer.buy()
