//
//  ViewModel.swift
//  FindNumber
//
//  Created by 전성훈 on 2023/12/06.
//

import Foundation

final class FindNumberModel {
    
    var urlSession: URLSessionProtocol = URLSession.shared
    
    var round: Int {
        get {
            let initialRound = UserDefaults.standard.integer(forKey: "Round")
            return initialRound == 0 ? 1 : initialRound
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Round")
        }
    }
    var bestRecord: Int {
        get {
            UserDefaults.standard.integer(forKey: "bestRecord")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "bestRecord")
        }
    }
    
    var currentRecord: Int {
        get {
            UserDefaults.standard.integer(forKey: "CurrentRecord")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CurrentRecord")
        }
    }
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    var target: Int = 1
    
    init() {
        gameStart()
    }
    
    private func gameStart() {
        getNumber { newTarget in
            print(newTarget)
            self.target = newTarget
        }
    }
    
    func checkNum(value: Int) {
        if value == target {
            if bestRecord == currentRecord {
                bestRecord += 1
            }
            round += 1
            currentRecord += 1
            
            gameStart()
        } else {
            round = 1
            currentRecord = 0
        }
        
        onUpdate?()
    }
    
    func resetStage() {
        round = 1
        currentRecord = 0
        bestRecord = 0
        
        onUpdate?()
    }
    
    func getNumber(completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "https://www.randomnumberapi.com/api/v1.0/random?min=1&max=3&count=1") else {
            onError?("Invalid URL")
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, _, error in
            do {
                guard let data = data, error == nil,
                      let newTarget = try JSONDecoder().decode([Int].self, from: data).first
                else { 
                    self.onError?("Network error or data is unavailable")
                    return
                }
                
                completion(newTarget)
            } catch {
                self.onError?("Decoding Error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
