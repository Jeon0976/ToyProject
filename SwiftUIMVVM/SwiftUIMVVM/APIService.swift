//
//  APIService.swift
//  SwiftUIMVVM
//
//  Created by 전성훈 on 6/5/24.
//

import Foundation
import Combine

final class APIService {
    static let shared = APIService()
    
    func getUsers() -> AnyPublisher<[User], Error> {
        guard let url = URL(string: "https://api.github.com/users") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
        
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        
                        let users = try JSONDecoder().decode([User].self, from: data)
                        return promise(.success(users))
                    } catch let error {
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
}
