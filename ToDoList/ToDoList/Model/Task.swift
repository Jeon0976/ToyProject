//
//  Task.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/22.
//

import Foundation

import RxDataSources

struct Task {
    var header: String?
    var items: [TodoList]
}

extension Task: SectionModelType {
    typealias Item = TodoList
    
    init(original: Task, items: [TodoList]) {
        self = original
        self.items = items
    }
}
