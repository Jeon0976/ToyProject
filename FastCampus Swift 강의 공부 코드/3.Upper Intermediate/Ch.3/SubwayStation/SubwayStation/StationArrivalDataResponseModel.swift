//
//  StationArrivalDataResponseModel.swift
//  SubwayStation
//
//  Created by 전성훈 on 2022/09/13.
//

import Foundation


struct StationArrivalDataResponseModel : Decodable {
    var realtimeArrivalList : [RealitimeArrival] = []
    
    struct RealitimeArrival : Decodable {
        let line: String
        let remainTime : String
        let currentStation : String
        
        enum CodingKeys : String, CodingKey {
            case line = "trainLineNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}

