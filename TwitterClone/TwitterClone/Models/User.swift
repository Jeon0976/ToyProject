//
//  User.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import Foundation

struct User: Codable, Equatable {
    var name: String
    var account: String
    
    static var shared = User(name: "나일론머스크", account: "GoToMoon")
    
    
}
