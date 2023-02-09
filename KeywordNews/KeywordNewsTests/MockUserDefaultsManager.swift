//
//  MockUserDefaultsManager.swift
//  KeywordNewsTests
//
//  Created by 전성훈 on 2023/02/09.
//

import Foundation

@testable import KeywordNews

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var isCalledGetTags = false
    var isCalledSetTags = false
    var isCalledDeleteTags = false
    
    func getTags() -> [KeywordNews.Tags] {
        isCalledGetTags = true
        return []
    }
    
    func setTags(_ newValues: KeywordNews.Tags) {
        isCalledSetTags = true
    }
    
    func deleteTags(_ values: [KeywordNews.Tags]) {
        isCalledDeleteTags = true
    }
}

