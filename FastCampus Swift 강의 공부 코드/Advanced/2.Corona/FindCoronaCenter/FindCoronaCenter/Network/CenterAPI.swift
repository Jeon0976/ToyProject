//
//  CenterAPI.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/24.
//

import Foundation

struct CenterAPI {
    static let scheme = "https"
    static let host = "api.odcloud.kr"
    static let path = "/api/15077586/v1/centers"
    
    func getCenterListComponents() -> URLComponents {
        var componenets = URLComponents()
        
        componenets.scheme = CenterAPI.scheme
        componenets.host = CenterAPI.host
        componenets.path = CenterAPI.path
        
        componenets.queryItems = [
            URLQueryItem(name: "perPage", value: "300")
        ]
        
        return componenets
    }
}
