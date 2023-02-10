//
//  TweetPresenter.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/10.
//

import UIKit

protocol TweetProtocol: AnyObject {
    func setupView(tweet: Tweet)
}

final class TweetPresenter {
    private weak var viewController: TweetProtocol?
    
    private let tweet: Tweet
    
    init(
        viewController: TweetProtocol,
        tweet: Tweet
    ) {
        self.viewController = viewController
        self.tweet = tweet
    }
    
    func viewDidLoad() {
        viewController?.setupView(tweet: tweet)
    }
}
