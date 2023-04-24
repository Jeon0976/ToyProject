//
//  MovieListPresenterTests.swift
//  MovieTests
//
//  Created by 전성훈 on 2023/01/10.
//

import XCTest

@testable import Movie

class MovieListPresenterTests: XCTestCase {
    var sut: MovieListPresenter!
    
    var viewController: MockMovieListViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    var movieSearchManager: MockMovieSearchManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieListViewController()
        movieSearchManager = MockMovieSearchManager()
        userDefaultsManager = MockUserDefaultsManager()
        
        sut = MovieListPresenter(
            viewController: viewController,
            movieSearchManager: movieSearchManager,
            userDefaultsManager: userDefaultsManager
        )
        
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        movieSearchManager = nil
        userDefaultsManager = nil
        
        super.tearDown()
    }
    
    /// BBD 분기 테스트 -> if, switch 문을 활용하는 함수를 시나리오 형식으로 테스트 개발
    // request 메소드가 성공하면 updateSearchTableView가 실행되고
    func test_searchBar_WhenTextDidChangeClickIfRequestSucceed() {
        movieSearchManager.needToSuccessRequest = true
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행된다.")
    }
    // request 메소드가 실패하면 updateSaerchTableView가 실행되지 않는다.
    func test_searchBar_WhenTextDidChangeClickIfRequestFailed() {
        movieSearchManager.needToSuccessRequest = false
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertFalse(viewController.isCalledUpdateSearchTableView,"updateSearchTableView가 실행되지 않는다.")
    }
    
    func test_WhenViewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetUpNavigatinoBar)
        XCTAssertTrue(viewController.isCalledSetUpSearchBar)
        XCTAssertTrue(viewController.isCalledSetUpViews)
    }
    
    func test_WhenViewWillAppear() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultsManager.isCalledGetMovies)
        XCTAssertTrue(viewController.isCalledUpdateCollectionView)
    }
    
    func test_WhenSearchBarTextDidBeginEditing() {
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }
    
    func test_WhenSearchBarCancelButtonClicked() {
        sut.searchBarCancelButtonClicked(UISearchBar())
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }
}
