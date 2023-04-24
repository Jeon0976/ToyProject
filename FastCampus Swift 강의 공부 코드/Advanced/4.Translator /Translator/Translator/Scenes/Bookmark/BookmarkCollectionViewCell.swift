//
//  BookmarkCollectionViewCell.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/14.
//

import UIKit
import SnapKit

final class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"
    
    private var sourceBookmarkTextStackView: BookmarkTextStackView!

    private var targetBookmarkTextStackView: BookmarkTextStackView!
    
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        
        return stackView
    }()
    
    func setUp(from bookmark: Bookmark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookmarkTextStackView(language: bookmark.sourceLanguage,
                                                            text: bookmark.soruceText,
                                                            type: .source)
        targetBookmarkTextStackView = BookmarkTextStackView(language: bookmark.translatedLanguage,
                                                            text: bookmark.translatedText,
                                                            type: .target)
        
        stackView.subviews.forEach {$0.removeFromSuperview()}
        
        [sourceBookmarkTextStackView,targetBookmarkTextStackView]
            .forEach { stackView.addArrangedSubview($0) }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
        }
        
//        // 긴 문장들어올 때
//        layoutIfNeeded()
    }
}
