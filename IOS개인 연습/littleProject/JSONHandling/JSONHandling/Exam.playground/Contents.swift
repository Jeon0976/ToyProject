import UIKit


// Encoder & Decoder Data
struct OrderedCoffe: Codable {
    var drink: Coffee
    var order: Customer
    
//    enum CodingKeys: String, CodingKey {
//        case drink = "nameOfBerverage"
//        case price
//        case order = "Customer"
//    }
}

struct Coffee: Codable {
    var coffee: String
    var price: Double
    var ice: Bool
}

struct Customer: Codable {
    var name: String
    var memberShip: String
}



let customer1 = Customer(name: "전성훈", memberShip: "VIP")
let customer2 = Customer(name: "가자지구", memberShip: "SILVER")
let coffe1 = Coffee(coffee: "아메리카노", price: 3.5, ice: true)
let coffe2 = Coffee(coffee: "아메리카노", price: 3.0, ice: false)
let coffe3 = Coffee(coffee: "카페라뗴", price: 4.5, ice: false)
let tee = Coffee(coffee: "아이스티", price: 4.5, ice: true)

let order1 = OrderedCoffe(drink: coffe1, order: customer1)
let order2 = OrderedCoffe(drink: coffe2, order: customer2)
let order3 = OrderedCoffe(drink: coffe1, order: customer2)
let order4 = OrderedCoffe(drink: coffe3, order: customer2)
let order5 = OrderedCoffe(drink: tee, order: customer2)
let order6 = OrderedCoffe(drink: tee, order: customer2)

let orders = [order1, order2, order3, order4, order5, order6]
var orderArray = [OrderedCoffe]()

for order in orders {
    orderArray.append(order)
}

var jsonData: Data?

// encoder
func orderCoffee() {
    let encoder = JSONEncoder()
    
    encoder.outputFormatting = .prettyPrinted
    
    do {
        let data = try encoder.encode(orderArray)
        print(String(data: data, encoding: .utf8)!)
        jsonData = data
    } catch {
        print(error)
    }
    
}


orderCoffee()

// decoder
func checkCoffee() {
    guard let jsonData = jsonData else { return }
    
    
    do {
        let order = try JSONDecoder().decode([OrderedCoffe].self, from: jsonData)
        print(order.count)
    } catch {
        print(error)
    }
}

checkCoffee()
