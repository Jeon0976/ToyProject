//
//  AppCoordiator.swift
//  CoordinatorWithSwiftUI
//
//  Created by 전성훈 on 6/5/24.
//

import UIKit
import SwiftUI

final class AppCoordiator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var finishDelegate: CoordinatorFinishDelegate?
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        showMain(navigationController: navigationController)
    }
    
    private func showMain(navigationController: UINavigationController) {
        let mainViewModel = MainViewModel()
        let mainView = MainView(viewModel: mainViewModel)
        let mainCoordinator = MainCoordinator(view: mainView)
        mainViewModel.setCoordinatorActions(with: mainCoordinator)

        mainCoordinator.start(navigationController: navigationController)
    }
}
