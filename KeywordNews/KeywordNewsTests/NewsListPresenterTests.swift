//
//  NewsListPresenterTests.swift
//  KeywordNewsTests
//
//  Created by 전성훈 on 2023/02/09.
//

import XCTest

@testable import KeywordNews

class NewsListPresenterTests: XCTestCase {
    var sut: NewsListPresenter!
    
    var viewController: MockNewsListViewController!
    var newSearchManager: MockNewsSearchManager!
    var userDefaultsManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockNewsListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        newSearchManager = MockNewsSearchManager()
        
        sut = NewsListPresenter(viewController: viewController, newsSearchManager: newSearchManager, userDefaultsManager: userDefaultsManager)
    }
    
    override func tearDown() {
        sut = nil
        newSearchManager = nil
        userDefaultsManager = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad_Requested() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupLayout)
        XCTAssertTrue(userDefaultsManager.isCalledGetTags)
    }
    
    func test_viewWillAppear_Requested() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultsManager.isCalledGetTags)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }
    
    func test_didCalledRefresh_Requested_Fail() {
        newSearchManager.error = NSError() as Error
        
        sut.didCalledRefresh()
        
        XCTAssertFalse(viewController.isCalledReloadTableView)
        XCTAssertFalse(viewController.isCalledEndRefreshing)
    }
    
    func test_didCalledRefresh_Requested_Success() {
        newSearchManager.error = nil
        
        sut.didCalledRefresh()
        
        XCTAssertTrue(viewController.isCalledReloadTableView)
        XCTAssertTrue(viewController.isCalledEndRefreshing)
    }
    
    func test_didCalledPlus() {
        sut.didCalledPlus()
        
        XCTAssertTrue(viewController.isCalledMoveToTagPlusViewController)
    }

}
