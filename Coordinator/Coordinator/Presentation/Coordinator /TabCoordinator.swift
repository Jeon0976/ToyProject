//
//  TabCoordinator.swift
//  Coordinator
//
//  Created by 전성훈 on 2023/10/29.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarPage)
    func setSelectedInedx(_ index: Int)
    func currentPage() -> TabBarPage?
}

final class TabCoordinator: NSObject, TabCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .plus, .myPage].sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        
        navController.setNavigationBarHidden(false, animated: false)
        
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(), image: nil, tag: page.pageOrderNumber())
        
        switch page {
        case .home:
            let homeVC = HomeViewController()
            
            homeVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .home:
                    self?.selectPage(.plus)
                }
            }
            
            navController.pushViewController(homeVC, animated: true)
        case .plus:
            let plusVC = PlusViewController()
            
            plusVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .plus:
                    self?.selectPage(.myPage)
                }
            }
            
            navController.pushViewController(plusVC, animated: true)
        case .myPage:
            let myPageVC = MyPageViewController()
            
            myPageVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .myPage:
                    self?.finish()
                }
            }
            
            navController.pushViewController(myPageVC, animated: true)
        }
        
        return navController
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UINavigationController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage.init(index: tabBarController.selectedIndex)
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedInedx(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
