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
    func deleteTags(_ values: [Tags])
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case tags
    }
    
    func getTags() -> [Tags] {
        guard let data = UserDefaults.standard.data(forKey: Key.tags.rawValue) else {return [ ]}
        return (try? PropertyListDecoder().decode([Tags].self, from: data)) ?? []
    }
    
    func setTags(_ newValues: Tags) {
        var currentTags: [Tags] = getTags()
        currentTags.insert(newValues, at: 0)
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(currentTags), forKey: Key.tags.rawValue)
    }
    
    func deleteTags(_ values: [Tags]) {
        let currentTags: [Tags] = getTags()
        
        let changeTags = currentTags.filter { !values.contains($0) }
        
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(changeTags), forKey: Key.tags.rawValue)
    }
}
