//
//  TranslateRequestModel.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/14.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String
}
