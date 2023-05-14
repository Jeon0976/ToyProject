//
//  AppDelegate.swift
//  Concurrency
//
//  Created by Allen on 2020/02/04.
//  Copyright © 2020 allen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let vc = ViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

