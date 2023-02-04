//
//  SceneDelegate.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.tintColor = .systemOrange
        window?.rootViewController = UINavigationController(rootViewController: NewsListViewController())
        window?.makeKeyAndVisible()
    }

}
