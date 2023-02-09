//
//  MockNewsListViewController.swift
//  KeywordNewsTests
//
//  Created by 전성훈 on 2023/02/09.
//

import Foundation

@testable import KeywordNews

final class MockNewsListViewController: NewsListProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupLayout = false
    var isCalledEndRefreshing = false
    var isCalledMoveToNewsWebViewController = false
    var isCalledMoveToTagPlusViewController = false
    var isCalledReloadTableView = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupLayout() {
        isCalledSetupLayout = true
    }
    
    func endRefreshing() {
        isCalledEndRefreshing = true
    }
    
    func moveToNewsWebViewController(with news: News) {
        isCalledMoveToNewsWebViewController = true
    }
    
    func moveToTagPlusViewController() {
        isCalledMoveToTagPlusViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    
}
