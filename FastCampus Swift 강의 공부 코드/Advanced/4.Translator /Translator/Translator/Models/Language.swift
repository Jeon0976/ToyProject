//
//  Language.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/13.
//

import Foundation
// CaseIterable -> enum을 array처럼 활용
enum Language: String, CaseIterable, Codable {
    case ko
    case en
    case de
    case ch = "zh-CN"
    
    var title: String {
        switch self {
        case .ko: return NSLocalizedString("Korean", comment: "한국어")
        case .en: return NSLocalizedString("English", comment: "영어")
        case .de: return NSLocalizedString("German", comment: "독일어")
        case .ch: return NSLocalizedString("Chinese", comment: "중국어")
        }
    }
    
    var languageCode: String {
        self.rawValue
    }
}
