//
//  MenuStore.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import Foundation

import RxSwift

protocol MenuFetchable {
    func fectchMenusRx() -> Observable<[MenuItem]>
}

class MenuStore: MenuFetchable {
    func fectchMenusRx() -> Observable<[MenuItem]> {
        struct Response: Decodable {
            let meuns: [MenuItem]
        }
        
        return APIService.fectchAllMenusRx()
            .map { data in
                guard let response = try?
                        JSONDecoder().decode(Response.self, from: data) else {
                    throw NSError(domain: "Decoding Error", code: -1, userInfo: nil)
                }
                return response.meuns
            }
    }
}
