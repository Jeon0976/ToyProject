//
//  SceneDelegate.swift
//  customTabBarController
//
//  Created by 전성훈 on 2023/11/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let firstViewController = TestViewController("1")
        firstViewController.view.backgroundColor = .gray
        firstViewController.title = "First"
        let firstNavi = UINavigationController(rootViewController: firstViewController)
        
        let secondViewController = TestViewController("2")
        secondViewController.view.backgroundColor = .darkGray
        secondViewController.title = "Second"
        let secondNavi = UINavigationController(rootViewController: secondViewController)
        
        let thirdViewController = TestViewController("3")
        thirdViewController.view.backgroundColor = .lightGray
        thirdViewController.title = "Third"
        let thirdNavi = UINavigationController(rootViewController: thirdViewController)
        
        let customTabBarController = CustomTabBarController()
        customTabBarController.setViewControllers([firstNavi, secondNavi, thirdNavi])
        
        window?.rootViewController = customTabBarController
        window?.makeKeyAndVisible()
    }


}

