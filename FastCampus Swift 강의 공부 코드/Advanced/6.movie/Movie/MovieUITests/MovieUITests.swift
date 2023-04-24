//
//  MovieUITests.swift
//  MovieUITests
//
//  Created by 전성훈 on 2023/01/04.
//

import XCTest

final class MovieUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
    }
    
    func test_navigationBarTitleIsMoiveragting() {
        let existNavigationBar = app.navigationBars["영화 평점"].exists
        XCTAssertTrue(existNavigationBar)
    }
    
    func test_SearchBarIsExist() {
        let existSearchBar = app.navigationBars["영화 평점"]
            .searchFields["Search"]
            .exists
        
        XCTAssertTrue(existSearchBar)
    }
    
        func test_CancelButtonIsExistInSearchBar() {
        let navigationBar = app.navigationBars["영화 평점"]
        navigationBar.searchFields["Search"]
            .tap()
        
        let existCancelButton = navigationBar
            .buttons["Cancel"]
            .exists
        
        XCUIApplication().navigationBars["영화 평점"].searchFields["Search"].tap()

        XCTAssertTrue(existCancelButton)
    }
}
