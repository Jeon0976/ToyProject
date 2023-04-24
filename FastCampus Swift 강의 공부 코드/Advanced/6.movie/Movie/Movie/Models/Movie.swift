//
//  Movie.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/04.
//

import Foundation

struct Movie: Codable {
    private let title: String
    /// 그냥 let image로 하면 타입이 UIImage 같아 보이기 때문에 private liet 설정
    private let image: String
    let userRating: String
    let director: String
    let actor: String
    let pubDate: String
    
    var imageURL: URL? { URL(string: image) }
    
    var filteringTitle: String {
        title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
//    private enum CodingKeys: String, CodingKey {
//        case title, image, userRating, director, actor, pubDate
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
//        image = try container.decodeIfPresent(String.self, forKey: .image) ?? "-"
//        userRating = try container.decodeIfPresent(String.self, forKey: .userRating) ?? "-"
//        director = try container.decodeIfPresent(String.self, forKey: .director) ?? "-"
//        actor = try container.decodeIfPresent(String.self, forKey: .actor) ?? "-"
//        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? "-"
//
//        isLiked = false
//
//    }
    
//    init(title: String,
//         imageURL: String,
//         userRating: String,
//         director: String,
//         actor: String,
//         pubDate: String,
//         isLiked: Bool
//    ) {
//        self.title = title
//        self.image = imageURL
//        self.userRating = userRating
//        self.director = director
//        self.actor = actor
//        self.pubDate = pubDate
//        self.isLiked = isLiked
//    }
}
