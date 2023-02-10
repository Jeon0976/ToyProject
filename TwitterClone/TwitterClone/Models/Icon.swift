//
//  Icone.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/10.
//

import UIKit

enum Icon {
    case like
    case comment
    case share
    case write
    
    var image: UIImage? {
        
        let systemName: String
        
        switch self {
        case .like: systemName = "heart"
        case .comment: systemName = "message"
        case .share: systemName = "square.and.arrow.up"
        case .write: systemName = "square.and.pencil"
        }
        

        return UIImage(systemName: systemName)
    }
}
