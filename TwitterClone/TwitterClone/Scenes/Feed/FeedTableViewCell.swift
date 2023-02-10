//
//  FeedTableViewCell.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/10.
//

import UIKit

import SnapKit

final class FeedTableViewCell: UITableViewCell {
    static let identifier = "FeedTableViewCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 21.0
        
        return imageView
    }()
    
    private lazy var nicnameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var acconutLabel: UILabel = {
       let label = UILabel()
        
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
       
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        
        button.setImage(Icon.like.image, for: .normal)
        button.tintColor = .secondaryLabel
        
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        
        button.setImage(Icon.comment.image, for: .normal)
        button.tintColor = .secondaryLabel
        
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        
        button.setImage(Icon.share.image, for: .normal)
        button.tintColor = .secondaryLabel
        
        return button
    }()
    
    func setup(tweet: Tweet) {
        selectionStyle = .none
        
        setupLayout()
        
        nicnameLabel.text = tweet.user.name
        acconutLabel.text = "@\(tweet.user.account)"
        contentsLabel.text = tweet.contents
    }
}

private extension FeedTableViewCell {
    func setupLayout() {
        let buttonStackView = UIStackView(
            arrangedSubviews: [likeButton, commentButton, shareButton]
        )
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        [
            profileImageView,
            nicnameLabel,
            acconutLabel,
            contentsLabel,
            buttonStackView
        ].forEach { addSubview($0) }
        
        let margin: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(margin)
            $0.top.equalToSuperview().inset(margin)
            $0.width.height.equalTo(40)
        }
        
        nicnameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(margin)
            $0.top.equalTo(profileImageView.snp.top)
        }
        
        acconutLabel.snp.makeConstraints {
            $0.leading.equalTo(nicnameLabel.snp.trailing).offset(2.0)
            $0.bottom.equalTo(nicnameLabel.snp.bottom)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.leading.equalTo(nicnameLabel.snp.leading)
            $0.top.equalTo(nicnameLabel.snp.bottom).offset(4.0)
            $0.trailing.equalToSuperview().inset(margin)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.equalTo(nicnameLabel.snp.leading)
            $0.trailing.equalTo(contentsLabel.snp.trailing)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(12.0)
            $0.bottom.equalToSuperview().inset(margin)
        }
    }
}
