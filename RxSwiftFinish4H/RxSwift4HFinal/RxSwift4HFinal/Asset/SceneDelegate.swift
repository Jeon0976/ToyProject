//
//  SceneDelegate.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = UINavigationController(rootViewController: MenuViewController())
        window?.makeKeyAndVisible()
    }

}
