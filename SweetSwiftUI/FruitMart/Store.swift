//
//  Store.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/05.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import Foundation

final class Store {
    var products: [Product]
    
    init(filename: String = "ProductData") {
        self.products = Bundle.main.jsonDecode(filename: filename, as: [Product].self)
    }
}
