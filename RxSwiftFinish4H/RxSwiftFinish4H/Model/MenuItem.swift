//
//  MenuItem.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/18.
//

import Foundation


/// 
struct MenuItem: Decodable {
    var name: String
    var price: Int
}

extension MenuItem: Equatable {
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
}
