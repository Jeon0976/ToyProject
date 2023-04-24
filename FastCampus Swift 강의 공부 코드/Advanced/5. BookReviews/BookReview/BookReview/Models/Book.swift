//
//  Book.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/22.
//

import Foundation


struct Book: Decodable {
    let title : String
    private let image : String?
    let author : String?
    
    var imageURL: URL? { URL(string: image ?? "") }
    
    init(title: String, image: String?, author: String? = nil) {
        self.title = title
        self.image = image
        self.author = author
    }
}
