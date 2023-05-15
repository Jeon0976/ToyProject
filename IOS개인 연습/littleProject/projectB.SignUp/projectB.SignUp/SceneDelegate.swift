//
//  SceneDelegate.swift
//  projectB.SignUp
//
//  Created by 전성훈 on 2023/05/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = UINavigationController(rootViewController: LoginViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

