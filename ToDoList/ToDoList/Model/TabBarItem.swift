//
//  tabBarItem.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/20.
//

import UIKit

enum TabBarItem: CaseIterable {
    case cal
    case nowList
    case doneList
    
    var title: String {
        switch self {
        case .cal: return "달력"
        case .nowList: return "할일"
        case .doneList: return "완료"
        }
    }
    var icon: (default: UIImage, selected: UIImage) {
        switch self {
        case .cal:
            return (UIImage(systemName: "calendar.circle")!, UIImage(systemName: "calendar.circle.fill")!)
        case .nowList:
            return (UIImage(systemName: "list.bullet.circle")!, UIImage(systemName: "list.bullet.circle.fill")!)
        case .doneList:
            return (UIImage(systemName: "checkmark.circle")!, UIImage(systemName: "checkmark.circle.fill")!)
            
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .cal:
            let calenderViewController = CalenderViewController()
            let calenderViewModel = CalenderViewModel()
            calenderViewController.bind(calenderViewModel)
            return UINavigationController(rootViewController: calenderViewController)
        case .nowList:
            let nowListViewController = NowListViewController()
            let nowListViewModel = NowListViewModel()
            nowListViewController.bind(nowListViewModel)
            return UINavigationController(rootViewController: nowListViewController)
        case .doneList:
            let doneListViewController = DoneListViewController()
            let doneListViewModel = DoneListViewModel()
            doneListViewController.bind(doneListViewModel)
            return UINavigationController(rootViewController: doneListViewController)
        }
    }
    
}
