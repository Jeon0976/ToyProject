//
//  LikedMovie.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/07.
//

import Foundation


struct LikedMovie: Codable {
    let title: String
    var imageURL: URL
    let userRating: String
    let director: String
    let actor: String
    let pubDate: String
    var isliked: Bool
    
    init(title: String,
         imageURL: URL,
         userRating: String,
         director: String,
         actor: String,
         pubDate: String,
         isliked: Bool
    ) {
        self.title = title
        self.imageURL = imageURL
        self.userRating = userRating
        self.director = director
        self.actor = actor
        self.pubDate = pubDate
        self.isliked = isliked
    }
}
