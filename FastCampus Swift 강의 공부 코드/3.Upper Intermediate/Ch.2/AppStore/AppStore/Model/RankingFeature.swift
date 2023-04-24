//
//  RankingFeature.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/12.
//

import Foundation

struct RankingFeature : Decodable {
    let title : String
    let description: String
    let isInPurchaseApp : Bool
}
