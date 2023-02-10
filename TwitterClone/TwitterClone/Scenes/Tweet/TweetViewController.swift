//
//  TweetViewController.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/10.
//

import UIKit

import SnapKit

final class TweetViewController: UIViewController {
    // init에서 초기화하니깐 옵셔널 강제 해제
    private var presenter: TweetPresenter!
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 30.0
        
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
       
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var likeButton: UIButton = {
       let button = UIButton()
    
        button.setImage(Icon.like.image, for: .normal)
        button.tintColor = .secondaryLabel
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
       let button = UIButton()
        
        button.setImage(Icon.share.image, for: .normal)
        button.tintColor = .secondaryLabel
        
       return button
    }()
    
    
    
    init(tweet: Tweet) {
        super.init(nibName: nil, bundle: nil)
        
        presenter = TweetPresenter(viewController: self, tweet: tweet)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
    }
}

extension TweetViewController: TweetProtocol {
    func setupView(tweet: Tweet) {
        let userInfoStackView = UIStackView(arrangedSubviews: [nicnameLabel,acconutLabel])
        userInfoStackView.axis = .vertical
        userInfoStackView.distribution = .equalSpacing
        userInfoStackView.spacing = 4.0
        
        let buttonStackView = UIStackView(arrangedSubviews: [likeButton, shareButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        view.backgroundColor = .systemBackground
        
        [
            profileImageView,
            userInfoStackView,
            contentsLabel,
            buttonStackView
        ].forEach { view.addSubview($0) }
        
        let margin: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(margin)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(margin)
            $0.width.height.equalTo(60)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(margin)
            // 세로정렬
            $0.centerY.equalTo(profileImageView.snp.centerY)
        }

        contentsLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(margin*2)
            $0.top.equalTo(profileImageView.snp.bottom).offset(margin)
        }

        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(margin)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(margin)
        }
        
        nicnameLabel.text = tweet.user.name
        acconutLabel.text = "@\(tweet.user.account)"
        contentsLabel.text = tweet.contents
    }
}
