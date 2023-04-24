//
//  ReviewListPresenterTests.swift
//  ReviewListPresenterTests
//
//  Created by 전성훈 on 2022/12/19.
//

import XCTest
@testable import BookReview

final class ReviewListPresenterTests: XCTestCase {
    /// 테스트에서는 ? 보다는 !를 권장함 (무조건 존재한다는 느낌으로 실행)
    /// sut: system under test라는 단어의 약자
    /// https://junho85.pe.kr/1891
    var sut: ReviewListPresenter!
    var viewController : MockReviewListViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    
    var tableView: UITableView!
    private var dataSource: UITableViewDataSource!
    private var delegate: UITableViewDelegate!
    
    override func setUp() {
        super.setUp()
        
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
//        let itemXib = UINib.init(nibName: "ItemTableViewCell", bundle: nil)
//        tableView.register(itemXib, forCellReuseIdentifier: "itemCell")
//        dataSource = TableViewDataSource()
//        delegate = TableViewDelegate()
//        tableView.delegate = delegate
//        tableView.dataSource = dataSource
        
        viewController = MockReviewListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        
        
        sut = ReviewListPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager
        )
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_viewWillAppear() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledreloadTableView)
    }
    
    func test_didTapRightBarButtonItem() {
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledpresentToReviewWriteViewController)
    }
}
//    func testAwakeFromNib()  {
//        let indexPath = IndexPath(row: 0, section: 0)
//        let itemCell = createCell(indexPath: indexPath)
//    }
//}
//
//extension ReviewListPresenterTests {
//
//    func createCell(indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath)
//        XCTAssertNotNil(cell)
//
//        let view = cell.contentView
//        XCTAssertNotNil(view)
//
//        return cell
//    }
//}
//
//private class TableViewDataSource: NSObject, UITableViewDataSource {
//
//    var items = [BookReview]
//
//    override init() {
//        super.init()
//        // Initialize model, i.e. create&add object in items.
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell",
//                                                 for: indexPath)
//        return cell
//    }
//}
//
//private class TableViewDelegate: NSObject, UITableViewDelegate {
//
//}
