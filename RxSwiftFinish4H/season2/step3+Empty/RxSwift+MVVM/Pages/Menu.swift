//
//  Menu.swift
//  RxSwift+MVVM
//
//  Created by 전성훈 on 2023/04/17.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation

/// **ViewModel**
/// Model: View를 위한 Model
struct Menu: Identifiable {
    let id = UUID()
    var name: String
    var price: Int
    var count: Int
}


extension Menu {
    static func fromMenuItems(item: MenuItem) -> Menu {
        return Menu(name: item.name, price: item.price, count: 0)
    }
}
