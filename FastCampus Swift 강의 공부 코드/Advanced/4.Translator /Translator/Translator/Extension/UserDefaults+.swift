//
//  UserDefaults+.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/13.
//

import Foundation

extension UserDefaults {
    // enum으로 key값 설정시 유지보수 관점 등 에서 장점이 많음
    enum Key: String {
        case bookmarks
    }
    
    var bookmarks: [Bookmark] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.bookmarks.rawValue) else { return [] }
            
            return (try? PropertyListDecoder().decode([Bookmark].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue),
                                           forKey: Key.bookmarks.rawValue)
        }
    }
}
