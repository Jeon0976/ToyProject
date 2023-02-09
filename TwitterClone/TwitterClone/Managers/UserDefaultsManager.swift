//
//  UserDefaultsManager.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getTweet() -> [Tweet]
    func setTweet(_ newValue: Tweet)
    func removeTweet(_ values: Tweet)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case tweet
    }
    
    func getTweet() -> [Tweet] {
        guard let data = UserDefaults.standard.data(forKey: Key.tweet.rawValue) else { return []}
        
        return (try? PropertyListDecoder().decode([Tweet].self, from: data)) ?? []
    }
    
    func setTweet(_ newValue: Tweet) {
        var currentTweet: [Tweet] = getTweet()
        
        currentTweet.insert(newValue, at: 0)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currentTweet), forKey: Key.tweet.rawValue)
    }
    
    func removeTweet(_ values: Tweet) {
        let currentTweet: [Tweet] = getTweet()
        
        let changedTweet = currentTweet.filter { tweet in
            tweet != values
        }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(changedTweet), forKey: Key.tweet.rawValue)
    }
}
