//
//  NewsListViewController.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/02.
//

import UIKit

import SnapKit

final class NewsListViewController: UIViewController {
    private lazy var presenter = NewsListPresenter(viewController: self)
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(
            self,
            action: #selector(didCalledRefresh),
            for: .valueChanged
        )
        
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.refreshControl = refreshControl
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
        
        return tableView
    }()
    
    private lazy var rightBarButton: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus.circle")
        button.style = .plain
        button.target = self
        button.action = #selector(didCalledPlus)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension NewsListViewController: NewsListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "News"
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func moveToNewsWebViewController() {
        let webViewController = NewsWebViewController()
        navigationController?.pushViewController(
            webViewController,
            animated: true
        )
    }
}

private extension NewsListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
    
    @objc func didCalledPlus() {
        
    }
}
