//
//  SceneDelegate.swift
//  WKWebView
//
//  Created by 전성훈 on 2023/01/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        self.window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        self.window?.makeKeyAndVisible()
    }
}
