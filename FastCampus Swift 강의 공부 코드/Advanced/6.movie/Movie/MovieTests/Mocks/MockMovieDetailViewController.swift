//
//  MockMovieDetailViewController.swift
//  MovieTests
//
//  Created by 전성훈 on 2023/01/10.
//

import XCTest

@testable import Movie

final class MockMovieDetailViewController: MovieDetailProtocol {
    var isCalledSetViews = false
    var isCalledSetRightBarButton = false
    
    var settedIsLiked = false
    
    func setViews(with likedMovie: LikedMovie) {
        isCalledSetViews = true
    }
    
    func setRightBarButton(with isLiked: Bool) {
        settedIsLiked = isLiked
        
        isCalledSetRightBarButton = true
    }
}
