//
//  MainViewModel.swift
//  CoordinatorWithSwiftUI
//
//  Created by 전성훈 on 6/5/24.
//

import Foundation

protocol MainCoordinatorActions {
    func pushDetail()
}

final class MainViewModel: ObservableObject {
    private var actions: MainCoordinatorActions?
    
    init() { }
    
    func setCoordinatorActions(with actions: MainCoordinatorActions) {
        self.actions = actions
    }
    
    func pushDetail() {
        actions?.pushDetail()
    }
}
