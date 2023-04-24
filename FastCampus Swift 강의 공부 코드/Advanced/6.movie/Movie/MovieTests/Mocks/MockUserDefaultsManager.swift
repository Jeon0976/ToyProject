//
//  MockUserDefaultsManager.swift
//  MovieTests
//
//  Created by 전성훈 on 2023/01/10.
//

import XCTest

@testable import Movie

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var isCalledGetMovies = false
    var isCalledAddMovies = false
    var isCalledRemoveMovies = false
    
    func getMovies() -> [LikedMovie] {
        isCalledGetMovies = true
        return []
    }
    
    func addMovies(_ newValue: LikedMovie) {
        isCalledAddMovies = true
    }
    
    func removeMoives(_ value: LikedMovie) {
        isCalledRemoveMovies = true
    }
    
}
