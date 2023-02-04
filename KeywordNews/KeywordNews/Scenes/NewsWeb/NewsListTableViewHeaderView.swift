//
//  NewsListTableViewHeaderView.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/02.
//

import UIKit

import SnapKit
import TTGTags

final class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsListTableViewHeaderView"
    
    private var tags: [String] = ["Test", "Test2", "Test3", "Test4",
                                  "Test5", "testest", "testets2"]
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    func setUp() {
        contentView.backgroundColor = .systemBackground
        
        
    }
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
    
}

private extension NewsListTableViewHeaderView {
    func setupTagCollectionViewLayout() {
        addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupTagCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.numberOfLines = 2
        tagCollectionView.scrollDirection = .horizontal
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.selectionLimit = 1
        
        let insetVale: CGFloat = 16.0
        tagCollectionView.contentInset = UIEdgeInsets(
            top: insetVale,
            left: insetVale,
            bottom: insetVale,
            right: insetVale
        )
        
        let cornerRadiousValue: CGFloat = 12.0
        let shadowOpacityValue: CGFloat = 0.0
        let extraSpaceValue = CGSize(width: 20.0, height: 12.0)
        
        let nonSelectedStyle = TTGTextTagStyle()
        nonSelectedStyle.backgroundColor = .systemOrange
        nonSelectedStyle.cornerRadius = cornerRadiousValue
        nonSelectedStyle.borderWidth = 0.0
        nonSelectedStyle.shadowOpacity = shadowOpacityValue
        nonSelectedStyle.extraSpace = extraSpaceValue
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .white
        selectedStyle.cornerRadius = cornerRadiousValue
        selectedStyle.borderColor = .systemOrange
        selectedStyle.borderWidth = 1.0
        selectedStyle.shadowOpacity = shadowOpacityValue
        selectedStyle.extraSpace = extraSpaceValue
        
        tags.forEach { tag in
            
        }
    }
}
