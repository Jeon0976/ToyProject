//
//  SceneDelegate.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
    
        self.window?.rootViewController = UINavigationController(rootViewController: MenuViewController())
        self.window?.makeKeyAndVisible()
    }
}

