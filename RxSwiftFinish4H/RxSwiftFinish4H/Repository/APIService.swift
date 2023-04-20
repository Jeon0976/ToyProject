//
//  APIService.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/18.
//

import Foundation

import RxSwift

let MenuUrl = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"

class APIService {
    /// Data 또는 Error 형식으로 내보내는 URLSession을 포함한 함수
    /// 비동기 데이터를 클로저 형태로 반환
    static func fetchAllMenus(onComplete: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: MenuUrl)!) { data, res, err in
            if let err = err {
                onComplete(.failure(err))
                return
            }
            guard let data = data else {
                let httpResponse = res as! HTTPURLResponse
                onComplete(.failure(NSError(domain: "no data", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            onComplete(.success(data))
        }.resume()
    }
    
    /// fetchAllMenus 함수를 Rx에서 활용할 수 있도록 변경시킨 함수
    /// 비동기 데이터를 return 형태로 반환
    static func fetchAllMenusRx() -> Observable<Data> {
        return Observable.create { emitter in
            fetchAllMenus() { result in
                switch result {
                case let .success(data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    // RxSwift X
    static func fetchMenus(completion: @escaping ([MenuItem]?, Error?) -> Void) {
        struct Response: Decodable {
            let menus: [MenuItem]
        }

        URLSession.shared.dataTask(with: URL(string: MenuUrl)!) { data, res, err in
            if let err = err {
                completion(nil, err)
                return
            }
            guard let data = data else {
                let httpResponse = res as! HTTPURLResponse
                completion(nil, NSError(domain: "no data", code: httpResponse.statusCode, userInfo: nil))
                return
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(response.menus, nil)
            } catch let error {
                completion(nil,error)
            }
        }.resume()
    }
}
