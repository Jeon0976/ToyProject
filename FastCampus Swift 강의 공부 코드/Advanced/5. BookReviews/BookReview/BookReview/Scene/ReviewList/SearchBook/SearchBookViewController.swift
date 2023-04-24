//
//  SearchBookViewController.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/21.
//

import UIKit
import SnapKit

final class SearchBookViewController: UIViewController {
    private lazy var presenter = SearchBookPresenter(viewController: self,
                                                     delegate: searchBookDelegate)
    
    private let searchBookDelegate: SearchBookDelegate
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        return tableView
    }()
    
    // delegate 값을 받을 수 있도록 생성
    init(searchBookDelegate: SearchBookDelegate) {
        self.searchBookDelegate = searchBookDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}


extension SearchBookViewController: SearchBookProtocol {
    func setUpViews() {
        view.backgroundColor = .systemBackground
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        
        navigationItem.searchController = searchController
        navigationItem.title = "검색"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func dismiss() {
        // 더블 클릭되는 것을 원 클릭으로 변경하는 방법
        navigationItem.searchController?.dismiss(animated: true)
        dismiss(animated: true)
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}
