//
//  Coordinator.swift
//  CoordinatorWithSwiftUI
//
//  Created by 전성훈 on 6/4/24.
//

import SwiftUI

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start(navigationController: UINavigationController)
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinators()
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        if !childCoordinators.contains(where: { $0 === coordinator }) {
            childCoordinators.append(coordinator)
        }
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeChildCoordinators() {
        childCoordinators.forEach {
            $0.removeChildCoordinators()
        }
        
        childCoordinators.removeAll()
    }
}


protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
