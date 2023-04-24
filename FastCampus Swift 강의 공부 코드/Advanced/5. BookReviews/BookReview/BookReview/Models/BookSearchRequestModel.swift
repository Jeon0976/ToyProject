//
//  BookSearchRequestModel.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/22.
//

import Foundation


struct BookSearchRequestModel: Codable {
    /// 검색할 책 키워드
    let query: String
}
