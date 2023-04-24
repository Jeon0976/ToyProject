//
//  Feature.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/12.
//

import Foundation

struct Feature : Decodable {
    let type : String
    let appName : String
    let description : String
    let imageURL : String
}
