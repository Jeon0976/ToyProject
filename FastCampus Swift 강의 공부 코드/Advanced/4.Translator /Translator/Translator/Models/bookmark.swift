//
//  bookmark.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/13.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage : Language
    let translatedLanguage : Language
    
    let soruceText: String
    let translatedText: String
}

