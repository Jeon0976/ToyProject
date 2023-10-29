//
//  SceneDelegate.swift
//  Coordinator
//
//  Created by 전성훈 on 2023/10/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        
        window?.rootViewController = navigationController

        coordinator = AppCoordinator(navigationController)
        coordinator.start()
        
        window?.makeKeyAndVisible()
    }
}
