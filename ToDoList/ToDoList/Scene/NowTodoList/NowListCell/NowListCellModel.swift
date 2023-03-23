//
//  NowListCellModel.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/21.
//

import RxSwift
import RxCocoa

struct NowListCellModel {
    // View -> ViewModel
    let todoText = PublishRelay<String?>()
}
