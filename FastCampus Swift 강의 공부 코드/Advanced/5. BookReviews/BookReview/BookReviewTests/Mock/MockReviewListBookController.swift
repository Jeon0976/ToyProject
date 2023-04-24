//
//  MockReviewListBookController.swift
//  BookReviewTests
//
//  Created by 전성훈 on 2022/12/27.
//

import UIKit

@testable import BookReview

/// presenter에서 protocol의 method가 원하는 타이밍에 불려졌는지 확인만 하면 됨.
final class MockReviewListViewController: ReviewListProtocol {
    /// 불려졌는지 안 불려졌는지 확인만 할 수있는 변수 생성
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledpresentToReviewWriteViewController = false
    var isCalledreloadTableView = false
    var isCalledpresentToDetailViewController = false
    
    func setUpNavigationBar() {
        /// presenterTests코드에서 확인할 부분은 method에 의해서 아래 변수가 true로 변했는지 아닌지 확인만 해주면 최종적으로 원하는 viewController의 method를 호출하는지 확인 할 수 있음
        isCalledSetupNavigationBar = true
    }
    
    func setUpViews() {
        isCalledSetupViews = true
    }
    
    func presentToReviewWriteViewController() {
        isCalledpresentToReviewWriteViewController = true
    }
    
    func reloadTableView() {
        isCalledreloadTableView = true
    }
    
    func presentToDetailViewController() {
        isCalledpresentToDetailViewController = true
    }
}
