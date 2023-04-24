//
//  MovieDetailPresenterTests.swift
//  MovieTests
//
//  Created by 전성훈 on 2023/01/10.
//

import XCTest

@testable import Movie

class MovieDetailPresenterTests: XCTestCase {
    var sut: MovieDetailPresenter!
    
    var viewController: MockMovieDetailViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    var likedMovie: LikedMovie!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieDetailViewController()
        userDefaultsManager = MockUserDefaultsManager()
        likedMovie = LikedMovie(title: "",
                                /// 이래서 string으로 값을 받아야 하는거구만
                                imageURL: URL(string: " ")!,
                                userRating: "",
                                director: "",
                                actor: "",
                                pubDate: "",
                                isliked: false)
        
        sut = MovieDetailPresenter(viewController: viewController,
                                   likedMovie:
                                    likedMovie,
                                   userDefaultsManager: userDefaultsManager)
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        likedMovie = nil
        userDefaultsManager = nil
        
        super.tearDown()
    }
    
    func test_WhenViewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetViews)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
    
    // isLiked true
    func test_WhenDidTapRightBarButtonItem_isLikedBecameTrue() {
        likedMovie.isliked = false
        
        sut.didTapRightBarButtonItem()
        
        
        XCTAssertTrue(userDefaultsManager.isCalledAddMovies)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)

    }
    // isLiked false
    func test_WhenDidTapRightBarButtonItem_isLikedBecameFalse() {
        likedMovie.isliked = true
        
        sut.didTapRightBarButtonItem()
        
        XCTAssertFalse(userDefaultsManager.isCalledAddMovies)
        XCTAssertTrue(userDefaultsManager.isCalledRemoveMovies)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
}
