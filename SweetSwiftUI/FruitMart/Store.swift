//
//  Store.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/05.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import Foundation

final class Store: ObservableObject {
    @Published var products: [Product]
    @Published var orders: [Order] = []
    
    init(filename: String = "ProductData") {
        self.products = Bundle.main.jsonDecode(filename: filename, as: [Product].self)
    }
}

extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(where: { $0.id == product.id }) else { return }
        
        products[index].isFavorite.toggle()
    }
    
    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        let order = Order(id: nextID, product: product, quantity: quantity)
        orders.append(order)
        print(order)
    }
}
