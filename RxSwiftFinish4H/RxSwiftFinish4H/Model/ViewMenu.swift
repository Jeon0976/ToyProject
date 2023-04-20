//
//  ViewMenu.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/19.
//

import Foundation

struct ViewMenu : Identifiable {
    var id = UUID()
    var name: String
    var price: Int
    var count: Int
    
    init(_ item: MenuItem) {
        name = item.name
        price = item.price
        count = 0
    }
    
    init(name: String, price: Int, count: Int) {
        self.name = name
        self.price = price
        self.count = count
    }
    
    func countUpdate(_ count: Int) -> ViewMenu {
        return ViewMenu(name: name, price: price, count: count)
    }
    
    func asMenuItem() -> MenuItem {
        return MenuItem(name: name, price: price)
    }
    
}

