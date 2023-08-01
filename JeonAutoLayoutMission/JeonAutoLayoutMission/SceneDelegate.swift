//
//  SceneDelegate.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

