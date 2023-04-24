//
//  SceneDelegate.swift
//  SubwayStation
//
//  Created by 전성훈 on 2022/09/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainViewController = UINavigationController(rootViewController: StationSearchViewController())         
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }

}

