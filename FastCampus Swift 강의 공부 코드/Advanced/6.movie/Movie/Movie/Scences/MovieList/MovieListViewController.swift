//
//  MoiveListViewController.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/04.
//

import UIKit

import SnapKit

final class MovieListViewController: UIViewController {

    private lazy var presenter = MovieListPresenter(viewController: self)
    
    private let searchController = UISearchController()

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        
        collectionView.register(MovieListCollectionViewCell.self,
                                forCellWithReuseIdentifier:
                                    MovieListCollectionViewCell.identifier)

        return collectionView
    }()
    
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

}

extension MovieListViewController: MovieListProtocol {
    func setUpNavigationBar() {
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setUpSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }
    
    func setUpViews() {
        [collectionView, searchResultTableView]
            .forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        // search 실행 시 tableView 활성화를 위함
        searchResultTableView.isHidden = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        searchResultTableView.isHidden = isHidden
        searchResultTableView.reloadData() 
    }
    
    func pushToMovieDetailViewController(with likedMovie: LikedMovie) {
        let movieDetailViewController = MovieDetailViewController(likedMovie: likedMovie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
