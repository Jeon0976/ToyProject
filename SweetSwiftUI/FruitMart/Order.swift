//
//  Order.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/07.
//  Copyright © 2023 Giftbot. All rights reserved.
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
