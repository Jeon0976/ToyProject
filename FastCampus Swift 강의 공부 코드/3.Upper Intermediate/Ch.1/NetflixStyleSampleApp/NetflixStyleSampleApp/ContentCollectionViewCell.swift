//
//  ContentCollectionViewCell.swift
//  NetflixStyleSampleApp
//
//  Created by 전성훈 on 2022/09/03.
//

import UIKit
import SnapKit

class ContentCollectionViewCell : UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // contentView 자체를 super view로 봄
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        // snapkit 사용
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}
