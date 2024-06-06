//
//  SceneDelegate.swift
//  CoordinatorWithSwiftUI
//
//  Created by 전성훈 on 6/4/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator = AppCoordiator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        appCoordinator.start(navigationController: UINavigationController())
    }

}

