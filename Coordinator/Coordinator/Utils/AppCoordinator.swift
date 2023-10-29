//
//  AppCoordinator.swift
//  Coordinator
//
//  Created by 전성훈 on 2023/10/29.
//

import UIKit

// 해당 coordinator에서 어떤 flow에서 시작할지 결정한다.
protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

// AppCoordinator는 App's life cycle동안 단 하나만 존재한다.
final class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]() 
    var type: CoordinatorType { .app }
    
    private var isLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLogin")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLogin")
        }
    }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        print("AppCoordinator deinit")
    }
    
    func start() {
        if isLogin {
            showMainFlow()
        } else {
            showLoginFlow()
        }

    }
    
    func showLoginFlow() {
        // LoginFlow 구현
        let loginCoordinator = LoginCoordinator(navigationController)
        
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showMainFlow() {
        // MainFlow 구현
        let tabCoordinator = TabCoordinator(navigationController)
        
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        
        switch childCoordinator.type {
        case .tab:
            isLogin = false
            navigationController.viewControllers.removeAll()
            
            showLoginFlow()
        case .login:
            isLogin = true
            navigationController.viewControllers.removeAll()
            
            showMainFlow()
        default:
            break
        }
    }
}
