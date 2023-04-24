//
//  BookReview.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/22.
//

import Foundation

struct BookReview: Codable, Equatable {
    let title : String
    let author : String
    var contents: String
    let imageURL : URL?
    // contentes를 새로운 struct으로 해서 srp책임 줄이는건가??
//    let id = UUID()
}
