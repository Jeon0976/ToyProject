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
    
    private var tags: [Tags] = []
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    func setUp(tags: [Tags], delegate: NewsListTableViewHeaderViewDelegate) {
        self.tags = tags
        self.delegate = delegate
        
        contentView.backgroundColor = .systemBackground
        
            tagCollectionView.removeAllTags()
        
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
        /// 갱신없이 add만 해서 tag를 누를때마다 계속 생성됨, 즉 remove하고 add 해야함.
        /// 하지만, 이렇게했더니 눌렀을때 고정이 안됨.
        /// 고정을 위해선, 조건문 하나 더 생성해야되나??
        tags.forEach { tag in
            let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            
            let nonSelectedTagContents = TTGTextTagStringContent(
                text: tag.tag,
                textFont: font,
                textColor: .white
            )
            
            let selectedTagContents = TTGTextTagStringContent(
                text: tag.tag,
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
        }
        tagCollectionView.reload()
    }
}
