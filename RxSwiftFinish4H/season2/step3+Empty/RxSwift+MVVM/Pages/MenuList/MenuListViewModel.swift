//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 전성훈 on 2023/04/17.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// 함수형 프로그래밍
// 함수를 값처럼 사용해서

class MenuListViewModel {
    
    let disposeBag = DisposeBag()
    
    var menus:[Menu] = []
    
    // subject는 에러 발생하면 끊어짐
    // 하지만, UI 작업에서는 끊어지면 안 되기 때문에 새로운 메서드 생성함
//    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    var menuObservable = BehaviorRelay<[Menu]>(value: [])
    
    
    lazy var itemsCount = menuObservable.map {
        $0.map { $0.count }.reduce(0, +)
        
    }
    
    lazy var totalPrice = menuObservable.map {
        $0.map { $0.price * $0.count }.reduce(0, +)
        
    }
    
    init() {
//        let menus: [Menu] = [
//                Menu(name: "튀김1", price: 100, count: 0),
//                Menu(name: "튀김2", price: 200, count: 0),
//                Menu(name: "튀김3", price: 300, count: 0),
//                Menu(name: "튀김4", price: 300, count: 0),
//                Menu(name: "튀김5", price: 300, count: 0),
//                Menu(name: "튀김6", price: 300, count: 0)
//        ]
       let menus = APIService.fetchAllMenusRX()
            .map { data in
                struct Response: Decodable {
                    let menus: [MenuItem]
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)
                
                return response.menus
            }
            .map { menuItems in
                menuItems.map { Menu.fromMenuItems(item: $0)}
            }
            
        menus.subscribe { menus in
            self.menus = menus
            self.menuObservable.accept(self.menus)
        }
        .disposed(by: disposeBag)
    }
    
    func clearAllItemSelections() {
        // take(1) ??
//        menuObservable
//            .map { menus in
//                return menus.map { m in
//                    Menu(name: m.name, price: m.price, count: 0)
//                }
//            }
//            .take(1)
//            .subscribe(onNext: {
//                self.menuObservable.onNext($0)
//            })
//            .disposed(by: disposeBag)
        menus.indices.forEach { index in
            menus[index].count = 0
        }
        menuObservable.accept(menus)
    }
    
    func changeCount(_ item: Menu, _ increase: Int) {
        if let index = menus.firstIndex(where: { $0.id == item.id }) {
//            if menus[index].count + increase < 0 {
//                menus[index].count = 0
//            } else {
//                menus[index].count += increase
//            }
            menus[index].count += increase
            menus[index].count = max(menus[index].count, 0)
        }
        menuObservable.accept(menus)
    }
    
    func onOrder() -> [Menu]{
       var selectedMenus =  menus.filter { $0.count > 0 }
        
//        if selectedMenus.count == 0 {
//            let err = NSError(domain: "No Orders", code: -1, userInfo: nil)
//        }
        
        return selectedMenus
    }
}
