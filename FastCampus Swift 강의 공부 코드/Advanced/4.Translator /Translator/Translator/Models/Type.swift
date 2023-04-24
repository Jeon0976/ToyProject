//
//  Type.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/14.
//

import UIKit

enum `Type` {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}
