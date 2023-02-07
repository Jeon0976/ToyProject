//
//  TagPlusCollectionViewCell.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/04.
//

import UIKit

import SnapKit

final class TagPlusCollectionViewCell: UICollectionViewCell {
    static let identifier = "TagPlusCollectionViewCell"
        
    private lazy var label: UILabel = {
       var label = UILabel()
        
        label = PaddingLabel()
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        label.textColor = .white
        label.layer.backgroundColor = UIColor.systemOrange.cgColor
        label.layer.cornerRadius = 12.0
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "checkmark.circle.fill")
        image.isHidden = true
        
        return image
    }()
    
    func setup(tag: Tags) {
        backgroundColor = .systemBackground
        [label, image].forEach { addSubview($0) }
        label.text = tag.tag
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        image.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func clicked(_ value: Bool) {
        if value {
            label.alpha = 0.5
            image.isHidden = false
        } else {
            label.alpha = 1
            image.isHidden = true
        }
    }
    
}

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
