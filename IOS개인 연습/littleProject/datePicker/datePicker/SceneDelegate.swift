//
//  SceneDelegate.swift
//  datePicker
//
//  Created by 전성훈 on 2023/05/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let first = UINavigationController(rootViewController: ViewController())
        let second = UINavigationController(rootViewController: ViewController())
        let thrid = UINavigationController(rootViewController: ViewController())

        let tabBarController = UITabBarController()
        
        tabBarController.setViewControllers([first, second, thrid], animated: true)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

