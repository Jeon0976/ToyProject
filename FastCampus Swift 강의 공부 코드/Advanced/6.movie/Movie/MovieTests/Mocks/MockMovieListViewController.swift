//
//  MockMovieListViewController.swift
//  MovieTests
//
//  Created by 전성훈 on 2023/01/10.
//

import XCTest

@testable import Movie

final class MockMovieListViewController: MovieListProtocol {
    var isCalledSetUpNavigatinoBar = false
    var isCalledSetUpSearchBar = false
    var isCalledSetUpViews = false
    var isCalledUpdateSearchTableView = false
    var isCalledpushToMovieDetailViewController = false
    var isCalledUpdateCollectionView = false
    
    func setUpNavigationBar() {
        isCalledSetUpNavigatinoBar = true
    }
    
    func setUpSearchBar() {
        isCalledSetUpSearchBar = true
    }
    
    func setUpViews() {
        isCalledSetUpViews = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        isCalledUpdateSearchTableView = true
    }
    
    func pushToMovieDetailViewController(with likedMovie: LikedMovie) {
        isCalledpushToMovieDetailViewController = true
    }
    
    func updateCollectionView() {
        isCalledUpdateCollectionView = true
    }
}
