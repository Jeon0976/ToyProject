//
//  MockMovieSearchManager.swift
//  MovieTests
//
//  Created by 전성훈 on 2023/01/10.
//

import XCTest

@testable import Movie

final class MockMovieSearchManager: MovieSearchManagerProtocol {
    var isCalledRequest = false
    
    var needToSuccessRequest = false
    
    func reqeuset(
        from keyword: String,
        completionHandler: @escaping ([Movie]) -> Void) {
            isCalledRequest = true
            
            if needToSuccessRequest {
                completionHandler([])
            }
        }
    
}

