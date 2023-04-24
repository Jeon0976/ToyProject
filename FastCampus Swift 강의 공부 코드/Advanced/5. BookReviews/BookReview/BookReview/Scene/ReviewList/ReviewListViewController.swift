//
//  ReviewListViewController.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/19.
//

import UIKit
import SnapKit


final class ReviewListViewController: UIViewController {
    
    private lazy var presenter = ReviewListPresenter(viewController: self)
    
//    private var reviewListDelegate: ReviewListDelegate?
                    
    private lazy var tableView: UITableView =  {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        
        return tableView
    }()
    
//    init(reviewListDelegate: ReviewListDelegate) {
//        self.reviewListDelegate = reviewListDelegate
//        
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}



extension ReviewListViewController : ReviewListProtocol {
    func setUpNavigationBar() {
        navigationItem.title = "도서 리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func presentToReviewWriteViewController() {
        let vc = ReviewWriteViewController()

        let navigationView = UINavigationController(rootViewController: vc)
        navigationView.modalPresentationStyle = .fullScreen
        present(navigationView, animated: true)
    }
    
    func presentToDetailViewController() {
        // 왜 근데 여기서 초기화를 한 번더했다고 데이터는 전송되지만 view는 업데이트를 못하는가??
        let vc = DetailBookViewController()
        presenter.delegate = vc
        // delegate 를 여기서 선언해야 함
        let navigationView = UINavigationController(rootViewController: vc)
        navigationView.modalPresentationStyle = .fullScreen
        present(navigationView, animated: true)
    }
    
}


private extension ReviewListViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}

