//
//  TabBarPage.swift
//  Coordinator
//
//  Created by 전성훈 on 2023/10/29.
//

import Foundation

enum TabBarPage {
    case home
    case plus
    case myPage
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .plus
        case 2:
            self = .myPage
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .plus:
            return "Plus"
        case .myPage:
            return "MyPage"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .plus:
            return 1
        case .myPage:
            return 2
        }
    }
}
