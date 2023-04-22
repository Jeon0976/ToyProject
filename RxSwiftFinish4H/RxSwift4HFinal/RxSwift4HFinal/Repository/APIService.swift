//
//  APIService.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import Foundation

import RxSwift

let menuUrl = """
                https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.
                json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936
              """

class APIService {
    static func fecthAllMenus(onComplete: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: menuUrl)!) { data, res, err in
            if let err = err {
                onComplete(.failure(err))
                return
            }
            
            guard let data = data else {
                let httpResponse = res as? HTTPURLResponse
                onComplete(.failure(NSError(domain: "no data", code: httpResponse!.statusCode, userInfo: nil)))
                return
            }
            onComplete(.success(data))
        }.resume()
    }
    
    static func fectchAllMenusRx() -> Observable<Data> {
        return Observable.create { emitter in
            fecthAllMenus { result in
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
}
