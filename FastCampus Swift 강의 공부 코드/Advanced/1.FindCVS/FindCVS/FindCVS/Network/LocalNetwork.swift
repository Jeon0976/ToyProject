//
//  LocalNetwork.swift
//  FindCVS
//
//  Created by 전성훈 on 2022/11/14.
//

import RxSwift

class LocalNetwork {
    private let session : URLSession
    let api = LocalAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<Location, URLError>> {
        guard let url = api.getLocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK d33343d48f9cea4bb463ce4d92f57e58", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let locationData = try JSONDecoder().decode(Location.self, from: data)
                    return .success(locationData)
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch{_ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
            .asSingle()
    }
}
