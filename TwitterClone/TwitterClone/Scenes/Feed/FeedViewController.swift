//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import UIKit

import SnapKit

final class FeedViewControler: UIViewController {
    private lazy var presenter = FeedPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
       
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        
        return tableView
    }()
    
    private lazy var floatyButton: UIButton = {
        let button = UIButton()
                
        button.setImage(Icon.write.image, for: .normal)
        button.tintColor = .white
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.systemCyan.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize.zero
        
        button.addTarget(self, action: #selector(didTapFlotyButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension FeedViewControler: FeedProtocol {
    func setupView() {
        navigationItem.title = "Feed"
        
        [
            tableView, floatyButton
        ].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        floatyButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(50)
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func moveToTweetViewController(with tweet: Tweet) {
        let tweetViewController = TweetViewController(tweet: tweet)
        
        navigationController?.pushViewController(tweetViewController, animated: true)
    }
    
    func moveToWriteViewController() {
        let writeViewController = UINavigationController(rootViewController: WriteViewController())
        
        writeViewController.modalPresentationStyle = .fullScreen
        present(writeViewController, animated: true)
    }
}

private extension FeedViewControler {
    @objc func didTapFlotyButton() {
        presenter.didTapFlotyButton()
    }
}
