//
//  MenuItem.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import Foundation

struct MenuItem: Decodable {
    var name: String
    var price: Int
    
    
    func asViewMenu() -> ViewMenu {
        ViewMenu(self)
    }
}
