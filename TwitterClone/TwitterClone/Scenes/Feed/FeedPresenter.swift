//
//  FeedPresenter.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import UIKit

protocol FeedProtocol: AnyObject {
    func setupView()
    func reloadTableView()
    func moveToTweetViewController(with tweet: Tweet)
    func moveToWriteViewController()
}

final class FeedPresenter:NSObject {
    private weak var viewController: FeedProtocol?
    
    private var tweets: [Tweet] = []
    
    init(viewController: FeedProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
    }
    
    func didTapFlotyButton() {
        viewController?.moveToWriteViewController()
    }
}

extension FeedPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = tweets[indexPath.row]
        
        viewController?.moveToTweetViewController(with: tweet)
    }
}

extension FeedPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell
        
        let tweet = Tweet(user: User.shared, contents: "화성 갈끄니까~")
        tweets.append(tweet)
        
        cell?.setup(tweet: tweet)
        
        return cell ?? UITableViewCell()
    }
    
}
