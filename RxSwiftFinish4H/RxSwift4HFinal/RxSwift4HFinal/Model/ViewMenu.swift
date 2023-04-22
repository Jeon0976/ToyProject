//
//  ViewMenu.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import Foundation

struct ViewMenu: Identifiable {
    var id = UUID()
    var name: String
    var price: Int
    var count: Int
    
    init(_ item: MenuItem) {
        name = item.name
        price = item.price
        count = 0
    }
    
}
