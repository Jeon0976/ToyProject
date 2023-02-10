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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension FeedViewControler: FeedProtocol {
    func setupView() {
        navigationItem.title = "Feed"
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
