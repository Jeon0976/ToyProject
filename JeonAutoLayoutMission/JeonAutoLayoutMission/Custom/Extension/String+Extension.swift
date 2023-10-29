//
//  String+Extension.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/02.
//

import UIKit

extension String {
    func setLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributeString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributeString.length)
        )
        
        return attributeString
    }
    
    func changeColor(changedText: String) -> NSMutableAttributedString? {
        if let range = self.range(of: changedText) {
            let attributedText = NSMutableAttributedString(string: self)
            attributedText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(range, in: self))
            
            return attributedText
        }
        
        return nil
    }
}
