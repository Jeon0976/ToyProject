//
//  Order.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/28/24.
//

import Foundation

struct Order: Identifiable, Codable {
    static var orderSequence = sequence(first: lastOrderID + 1) { $0 &+ 1 }
    static var lastOrderID: Int {
        get { UserDefaults.standard.integer(forKey: "LastOrderID") }
        set { UserDefaults.standard.set(newValue, forKey: "LastOrderID")}
    }
    
    let id: Int
    let product: Product
    let quantity: Int
    
    var price: Int {
        product.price * quantity
    }
}
