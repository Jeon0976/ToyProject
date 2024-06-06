//
//  User.swift
//  SwiftUIMVVM
//
//  Created by 전성훈 on 6/5/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int
    var login: String?
    var avatar_url: String?
    
    init(
        id: Int,
        login: String?,
        avatar_url: String?
    ) {
        self.id = id
        self.login = login
        self.avatar_url = avatar_url
    }
}
