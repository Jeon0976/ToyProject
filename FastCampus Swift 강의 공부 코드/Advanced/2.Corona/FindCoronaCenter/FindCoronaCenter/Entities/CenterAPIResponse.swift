//
//  CenterAPIResponse.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/24.
//

import Foundation

struct CenterAPIResponse: Decodable {
    let data: [Center]
}
