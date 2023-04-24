//
//  UserDefaultsManager.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/22.
//

import Foundation

/// protocol로 한 이유는 test용 클래스를 만들기 위함
protocol UserDefaultsManagerProtocol {
    func getReviews() -> [BookReview]
    func setReviews(_ newValues: BookReview)
    func edtingReviews(_ newValues: BookReview)
    func deleteReviews(_ Values: BookReview)
}

// Test 작성을 조금 더 쉽게 하기위해 protocol 작성
struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case review
    }
    
    func getReviews() -> [BookReview] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else {return []}
        
        // what is ProptertyListDecoder
        return (try? PropertyListDecoder().decode([BookReview].self, from: data)) ?? []
    }
    
    func setReviews(_ newValues: BookReview) {
        var currentReviews: [BookReview] = getReviews()
        currentReviews.insert(newValues, at: 0)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }
    
    func edtingReviews(_ newValues: BookReview) {
        var currentReviews : [BookReview] = getReviews()
        currentReviews
            .indices
            .filter { currentReviews[$0].title == newValues.title}
            .forEach { currentReviews[$0].contents = newValues.contents }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }
    
    // forEach의 $0는 immutable이여서 for in 해야하나??
//        currentReviews.forEach {
//            if $0.self == newValues.self {
//                $0.contents = newValues.contents
//            }
//        }
//        for var currentReview in currentReviews {
//            if currentReview.title == newValues.title {
//                print("1.\(currentReview.contents)")
//                print("2.\(newValues.contents)")
//                currentReview.contents = newValues.contents
//                print("3.\(currentReview.contents)")
//            }
//            print(currentReview)
//            print(currentReviews)
//        }
//        print(currentReviews)
    // 왜 그냥 for문 했을 때는 배열 전체가 변경되지 않지??

    
    
    
    func deleteReviews(_ Values: BookReview) {
        var currentReviews: [BookReview] = getReviews()
        var count = 0
        for currentReview in currentReviews {
            if currentReview.self == Values.self {
                currentReviews.remove(at: count)
            }
            count += 1
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }
}
