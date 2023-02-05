//
//  UserDefaultsManager.swift
//  KeywordTags
//
//  Created by 전성훈 on 2023/02/05.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getTags() -> [Tags]
    func setTags(_ newValues: Tags)
    func deleteTags(_ values: Tags)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case news
    }
    
    func getTags() -> [Tags] {
        guard let data = UserDefaults.standard.data(forKey: Key.news.rawValue) else {return [ ]}
        return (try? PropertyListDecoder().decode([Tags].self, from: data)) ?? []
    }
    
    func setTags(_ newValues: Tags) {
        var currentTags: [Tags] = getTags()
        currentTags.insert(newValues, at: 0)
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(currentTags), forKey: Key.news.rawValue)
    }
    
    func deleteTags(_ values: Tags) {
        var currentTags: [Tags] = getTags()
        var count = 0
        
        for currentNew in currentTags {
            if currentNew.self == values.self {
                currentTags.remove(at: count)
            }
            count += 1
        }
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(currentTags), forKey: Key.news.rawValue)
    }
}
