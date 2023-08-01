//
//  TopView.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

final class TopView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func makeLayout() {
        
    }
    
    private func configureViewSize() {
        
    }
}


//let title =  "오전, 오후 풀타임 빡코딩 스터디\n빡코딩 하는 사람만"
//let attributedString = NSMutableAttributedString(string: title)
//let paragraphStyle = NSMutableParagraphStyle()
//paragraphStyle.lineSpacing = 5
//attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
//titleLabel.attributedText = attributedString
//titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
//titleLabel.translatesAutoresizingMaskIntoConstraints = false
//titleLabel.numberOfLines = 0
