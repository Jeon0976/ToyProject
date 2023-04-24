//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/09.
//

import UIKit
import SnapKit
import Kingfisher


 final class TodayCollectionViewCell : UICollectionViewCell {
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white

        return label
    }()
    
    private lazy var subTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white

        return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
     func setup(today : Today) {
            setupSubViews()
//            backgroundColor = .red
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 10
            
         subTitleLabel.text = today.subTitle
         descriptionLabel.text = today.description
         titleLabel.text = today.title
         
         if let imageURL = URL(string: today.imageURL) {
             imageView.kf.setImage(with: imageURL)
         }
        }
}

private extension TodayCollectionViewCell {
    func setupSubViews() {
        [imageView,titleLabel,subTitleLabel,descriptionLabel].forEach { addSubview($0) }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24.0)
            make.trailing.equalToSuperview().inset(24.0)
            make.top.equalToSuperview().inset(24.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(subTitleLabel)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(4.0)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
