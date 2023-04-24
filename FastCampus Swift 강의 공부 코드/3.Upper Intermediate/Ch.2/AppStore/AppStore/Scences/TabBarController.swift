//
//  TabBarController.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/09.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var todayViewController : UIViewController = {
        let viewController = TodayViewController()
        let tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "house"), tag: 0)
        viewController.tabBarItem = tabBarItem
        return viewController
    } ()
    
    private lazy var appViewController : UIViewController = {
        let viewController = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "bag.circle"), tag: 1)
        viewController.tabBarItem = tabBarItem
        return viewController
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let barApperance = UITabBarAppearance()
        tabBar.scrollEdgeAppearance = barApperance
        tabBar.standardAppearance = barApperance
        
//        tabBar.layer.borderWidth = 0.2
//        tabBar.layer.borderColor = UIColor.gray.cgColor
//        tabBar.clipsToBounds = true
//        tabBar.backgroundColor = .white
//        tabBar.alpha = 1
        viewControllers = [todayViewController, appViewController]
    }
    
}
