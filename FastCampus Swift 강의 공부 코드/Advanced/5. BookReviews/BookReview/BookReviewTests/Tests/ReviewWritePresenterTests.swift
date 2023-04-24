//
//  ReviewWritePresenterTests.swift
//  BookReviewTests
//
//  Created by 전성훈 on 2022/12/28.
//

import XCTest

@testable import BookReview

class ReviewWritePresenterTests: XCTestCase {
    var sut: ReviewWritePresenter!
    var viewController: MockReviewWriteViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewWriteViewController()
        userDefaultsManager = MockUserDefaultsManager()
        
        sut = ReviewWritePresenter(viewController: viewController,
                                  userDefaultsManager: userDefaultsManager)
        
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        userDefaultsManager = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
    
        XCTAssertTrue(viewController.isCalledSetUpNavigationBar)
        XCTAssertTrue(viewController.isCalledSetUpViews)
    }
    
    func test_didTapLeftBarButton() {
        sut.didTapLeftBarButton()

        XCTAssertTrue(viewController.isCalledShowCloseAlertController)
    }
    
    func test_didTapRgihtBarButton_NotExistedBook() {
        sut.didTapRightBarButton(contentsText: "Test")
        
        XCTAssertFalse(userDefaultsManager.isCalledSetReviews)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRgihtBarButton_ExistedBook_NotExistedContentsText() {
        sut.useForTest_MakeBook()
        sut.didTapRightBarButton(contentsText: nil)
        
        XCTAssertFalse(userDefaultsManager.isCalledSetReviews)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRgihtBarButton_ExistedBook_ContentsTextSamePlaceHolder() {
        sut.useForTest_MakeBook()
        sut.didTapRightBarButton(contentsText: sut.contentsTextViewPlaceHolderText)
        
        XCTAssertFalse(userDefaultsManager.isCalledSetReviews)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRgihtBarButton_ExistedBook_ContentsTextNotSamePlaceHolder() {
        sut.useForTest_MakeBook()
        sut.didTapRightBarButton(contentsText: "Test")
        // sut book이 private되어있어서 값을 직접 입력 못함 -> 값을 입력할 수 있게 함수를 하나 구성해야되나??
        XCTAssertTrue(userDefaultsManager.isCalledSetReviews)
        XCTAssertTrue(viewController.isCalledClose)
        
    }
    
    func test_didTapBookCheckButton() {
        sut.didTapBookCheckButton()
        
        XCTAssertTrue(viewController.isCalledPresentToSearchBookViewController)
    }
    
}


final class MockReviewWriteViewController: ReviewWriteProtocol {
    var isCalledSetUpNavigationBar = false
    var isCalledShowCloseAlertController = false
    var isCalledClose = false
    var isCalledSetUpViews = false
    var isCalledPresentToSearchBookViewController = false
    var isCalledUpdateViews = false
    
    func setUpNavigationBar() {
        isCalledSetUpNavigationBar = true
    }
    
    func showCloseAlertController() {
        isCalledShowCloseAlertController = true
    }
    
    func close() {
        isCalledClose = true
    }
    
    func setUpViews() {
        isCalledSetUpViews = true
    }
    
    func presentToSearchBookViewController() {
        isCalledPresentToSearchBookViewController = true
    }
    
    func updateViews(_ book: Book) {
        isCalledUpdateViews = true
    }
    
    
}
