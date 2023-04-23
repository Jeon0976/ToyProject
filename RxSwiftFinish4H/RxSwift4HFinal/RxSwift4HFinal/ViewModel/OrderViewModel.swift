//
//  OrderViewModel.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import Foundation

import RxSwift
import RxCocoa

protocol OrderViewModelType {
    var selectedMenus: BehaviorRelay<[ViewMenu]> { get }
    var orderedItems: Observable<String> { get }
    var itemsPrice: Observable<Int> { get }
    var vatPrice: Observable<Int> { get }
    var totalPrice: Observable<Int> { get }
}

final class OrderViewModel: OrderViewModelType {
    
    // ViewModel -> View
    var selectedMenus = BehaviorRelay<[ViewMenu]>(value: [])
    var orderedItems: Observable<String>
    var itemsPrice: Observable<Int>
    var vatPrice: Observable<Int>
    var totalPrice: Observable<Int>
    
    
    init(menus: [ViewMenu]) {
        
        selectedMenus.accept(menus)
        
        orderedItems = selectedMenus
            .map { $0.map { "\($0.name) \($0.count)개"}.joined(separator: "\n")}
            
        itemsPrice = selectedMenus
            .map { $0.map { $0.price * $0.count}.reduce(0, +)}
        
        vatPrice = itemsPrice
            .map { $0 / 95 }
        
        totalPrice = Observable.zip(itemsPrice, vatPrice)
            .map { $0 + $1 }
    }
}
