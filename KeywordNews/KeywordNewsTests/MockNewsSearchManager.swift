//
//  MockNewsSearchManager.swift
//  KeywordNewsTests
//
//  Created by 전성훈 on 2023/02/09.
//

import Foundation

@testable import KeywordNews

final class MockNewsSearchManager: NewsSearchManagerProtocol {
    var error: Error?
    var isCalledRequest = false
    
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([KeywordNews.News]) -> Void
    ) {
        isCalledRequest = true
        
        if error == nil {
            completionHandler([])
        }
    }
}
