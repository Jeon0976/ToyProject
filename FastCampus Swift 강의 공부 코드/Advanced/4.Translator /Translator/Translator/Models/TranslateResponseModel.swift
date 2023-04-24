//
//  TranslateResponseModel.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/14.
//

import Foundation

struct TranslateResponseModel: Decodable {
    private let message: Message
    
    var translatedText: String { message.result.translatedText }
    
    struct Message: Decodable {
        let result: Result
    }
    struct Result: Decodable {
        let translatedText: String
    }
}
