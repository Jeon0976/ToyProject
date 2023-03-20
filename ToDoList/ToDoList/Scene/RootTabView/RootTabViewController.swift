//
//  RootTabViewController.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/15.
//

import UIKit

import RxSwift
import RxCocoa

class RootTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        let tabBarViewControllers: [UIViewController] = TabBarItem.allCases.map { tabCase in
            
            let viewController = tabCase.viewController
            
            viewController.tabBarItem = UITabBarItem(
                title: tabCase.title,
                image: tabCase.icon.default,
                selectedImage: tabCase.icon.selected
            )
            return viewController
        }
        self.viewControllers = tabBarViewControllers
        self.selectedIndex = 1
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemGray6
    }
}
