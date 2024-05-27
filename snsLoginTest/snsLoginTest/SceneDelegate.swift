//
//  SceneDelegate.swift
//  snsLoginTest
//
//  Created by 전성훈 on 5/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            print(url)
            if url.absoluteString.starts(with: "snslogintest://") {
                print("Test")
                if let code = url.absoluteString.split(separator: "=").last.map({ String($0)}) {
                    print("code: \(code)")
                    LoginManager.shared.requestAccessToken(with: code)
                }
            }
        }
    }

}

