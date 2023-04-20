//
//  MenuStore.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/19.
//

import Foundation

import RxSwift

protocol MenuFetchable {
    func fetchMenusRx() -> Observable<[MenuItem]>
}

/// Json 형태의 Data를 MenuItem형태의 Observable로 파싱
class MenuStore: MenuFetchable {
    func fetchMenusRx() -> Observable<[MenuItem]> {
        struct Response: Decodable {
            let menus: [MenuItem]
        }
        
        /// return 형태로 받은 데이터를 Json 파씽
        return APIService.fetchAllMenusRx()
            .map { data in
                guard let response = try?
                        JSONDecoder().decode(Response.self, from: data) else {
                    throw NSError(domain: "Decoding Error", code: -1, userInfo: nil)
                }
                return response.menus
            }
    }
}


