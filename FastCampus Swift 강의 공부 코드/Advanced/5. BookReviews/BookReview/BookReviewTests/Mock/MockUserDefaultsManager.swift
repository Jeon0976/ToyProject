//
//  MockUserDefaultsManager.swift
//  BookReviewTests
//
//  Created by 전성훈 on 2022/12/27.
//

import UIKit

@testable import BookReview

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var isCalledGetReviews = false
    var isCalledSetReviews = false
    var isCalledEditingReviews = false
    var isCalledDeleteReviews = false
    
    func getReviews() -> [BookReview] {
        isCalledGetReviews = true
        
        return []
    }
    
    func setReviews(_ newValues: BookReview) {
        isCalledSetReviews = true
    }
    
    func edtingReviews(_ newValues: BookReview) {
        isCalledEditingReviews = true
    }
    
    func deleteReviews(_ newValues: BookReview) {
        isCalledDeleteReviews = true
    }
}
