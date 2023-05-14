//
//  PhotoCell.swift
//  Concurrency
//
//  Created by Allen on 2020/02/04.
//  Copyright © 2020 allen. All rights reserved.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    // 일반적으로 (변수 + didSet)으로 처리
    var url: URL? {
        didSet {
            guard let url = url?.absoluteString else { return }
            imageView.isLoading = true
            imageView.loadImage(with: url)
        }
    }
    
    // 커스텀이미지뷰 사용
    let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
