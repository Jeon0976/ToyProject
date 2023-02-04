//
//  String+.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/02.
//

import Foundation

// MARK: html 코드 관련 String 값 뽑기??
extension String {
    var htmlToString: String {
        guard let data = self.data(using: .utf8) else {return ""}
        
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            ).string
        } catch {
            return ""
        }
    }
}
