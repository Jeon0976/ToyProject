//
//  MovieListCollectionViewCell.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/04.
//

import UIKit

import Kingfisher
import SnapKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        // image가 넘치지 않도록 해주는 것
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var userRatingLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        
        return label
    }()
    
    func update(_ likedMovie: LikedMovie) {
        setUpView()
        setUpLayout()
        
        imageView.kf.setImage(with: likedMovie.imageURL)
        titleLabel.text = likedMovie.title
        userRatingLabel.text = "⭐️ \(likedMovie.userRating)"
    }
}

private extension MovieListCollectionViewCell {
    func setUpView() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8
        
        backgroundColor = .systemBackground
    }
    
    func setUpLayout() {
        [imageView, titleLabel, userRatingLabel]
            .forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        userRatingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }
}
