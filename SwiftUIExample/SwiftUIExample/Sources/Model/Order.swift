//
//  Order.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/28/24.
//

import Foundation

struct Order: Identifiable {
    static var orderSequence = sequence(first: 1) { $0 + 1 }
    
    let id: Int
    let product: Product
    let quantity: Int
    
    var price: Int {
        product.price * quantity
    }
}
