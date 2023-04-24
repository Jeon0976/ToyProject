//
//  UserDefaultsManager.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/07.
//

import Foundation

// protocol도 extension 가능 -> extension에서 설정한 것은 필수가 아님
protocol UserDefaultsManagerProtocol {
    func getMovies() -> [LikedMovie]
    func addMovies(_ newValue: LikedMovie)
    func removeMoives(_ value: LikedMovie)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case likedMovie
    }
    
    func getMovies() -> [LikedMovie] {
        guard let data = UserDefaults.standard.data(forKey: Key.likedMovie.rawValue) else {return []}
        
        return (try? PropertyListDecoder().decode([LikedMovie].self, from: data)) ?? []
    }
    
    func addMovies(_ newValue: LikedMovie) {
        var currentMovies: [LikedMovie] = getMovies()
        currentMovies.insert(newValue, at: 0)
        
        saveMoive(currentMovies)
    }
    
    func removeMoives(_ value: LikedMovie) {
        let currentMovies: [LikedMovie] = getMovies()
        let newValue = currentMovies.filter {
            $0.title != value.title
        }
        
        saveMoive(newValue)
    }
    
    private func saveMoive(_ newValue: [LikedMovie]) {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(newValue),
            forKey: Key.likedMovie.rawValue
        )
    }
}
