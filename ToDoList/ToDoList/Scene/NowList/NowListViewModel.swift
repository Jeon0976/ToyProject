//
//  NowListViewModel.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/20.
//

import RxSwift
import RxCocoa

struct NowListViewModel {
    let nowListCellModel = NowListCellModel()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    
    // View -> ViewModel
    
    init() {
        let data = ["Test", "Test2"]
        self.cellData = Driver.just(data)
    }
}
