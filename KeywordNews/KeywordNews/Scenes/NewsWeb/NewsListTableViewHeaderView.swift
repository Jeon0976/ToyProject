//
//  NewsListTableViewHeaderView.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/02.
//

import UIKit

import SnapKit
import TTGTags

protocol NewsListTableViewHeaderViewDelegate: AnyObject {
    func didSelectTag(_ seletedIndex: Int)
}

final class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsListTableViewHeaderView"
    
    private weak var delegate: NewsListTableViewHeaderViewDelegate?
    
    private var tags: [String] = []
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    func setUp(tags: [String], delegate: NewsListTableViewHeaderViewDelegate) {
        self.tags = tags
        self.delegate = delegate
        
        contentView.backgroundColor = .systemBackground
        
        setupTagCollectionViewLayout()
        setupTagCollectionView()
    }
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(
        _ textTagCollectionView: TTGTextTagCollectionView!,
        didTap tag: TTGTextTag!,
        at index: UInt
    ) {
        guard tag.selected else {return}
        delegate?.didSelectTag(Int(index))
    }
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
        tagCollectionView.numberOfLines = 1
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
            let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            
            let nonSelectedTagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: .white
            )
            
            let selectedTagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: .systemOrange
            )
            
            let tag = TTGTextTag(
                content: nonSelectedTagContents,
                style: nonSelectedStyle,
                selectedContent: selectedTagContents,
                selectedStyle: selectedStyle
            )
            
            tagCollectionView.addTag(tag)
            tagCollectionView.reload()
        }
    }
}
