//
//  MainCoordinator.swift
//  CoordinatorWithSwiftUI
//
//  Created by 전성훈 on 6/5/24.
//

import UIKit
import SwiftUI

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    var finishDelegate: CoordinatorFinishDelegate?
    
    private var mainView: MainView
    
    init(view: MainView) {
        self.mainView = view
    }
    
    func start(navigationController: UINavigationController) {
        let mainVC = UIHostingController(rootView: mainView)
        
        self.navigationController = navigationController
        self.navigationController?.pushViewController(mainVC, animated: true)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}

extension MainCoordinator: MainCoordinatorActions {
    func pushDetail() {
        
        let detailVC = UIHostingController(rootView: DetailView())
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
