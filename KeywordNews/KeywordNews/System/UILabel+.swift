//
//  UILabel+.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/08.
//

import UIKit

// MARK: UILabel Padding 넣기
final class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(
        top: 6,
        left: 10,
        bottom: 6,
        right: 10
    )
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}
