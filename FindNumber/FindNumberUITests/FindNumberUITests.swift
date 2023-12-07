//
//  FindNumberUITests.swift
//  FindNumberUITests
//
//  Created by 전성훈 on 2023/12/06.
//

import XCTest

final class FindNumberUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testStageAscent() {
        // given
        let button = app.buttons["1번"]
        let button2 = app.buttons["2번"]
        
        button.tap()
        button2.tap()
        button.tap()
        button2.tap()
        button.tap()
        button2.tap()
        button.tap()
        button2.tap()
        
        // then
        let stageLabel = app.staticTexts["최대: 0번 연속 성공!"]
        
        XCTAssertFalse(stageLabel.exists,  "Stage label should be updated to the correct stage number")
    }
}
