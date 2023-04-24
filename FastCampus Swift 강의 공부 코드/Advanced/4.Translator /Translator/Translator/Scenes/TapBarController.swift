//
//  TapBarController.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/12.
//

import UIKit

final class TapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let translateViewController = TranslateViewController()
        translateViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Translate", comment: "번역"),
            image: UIImage(systemName: "mic"),
            selectedImage: UIImage(systemName: "mic.fill"))
        
        let bookmarkViewController = UINavigationController(rootViewController: BookmarkCollectionView())
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Bookmark", comment: "즐겨찾기"),
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill"))
        
        viewControllers = [translateViewController,bookmarkViewController]
        tabBar.backgroundColor = .secondarySystemBackground
        
    }


}

