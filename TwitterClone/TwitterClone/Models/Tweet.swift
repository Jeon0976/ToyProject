//
//  Tweet.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import Foundation

struct Tweet: Codable, Equatable {
    let user: User
    let contents: String
    
    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        return lhs.user == rhs.user && lhs.contents == rhs.contents
    }

}
