//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {return}
        self.window = UIWindow(windowScene: windowScene)
        
        let mainViewController = RootTabViewController()
        
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
}
