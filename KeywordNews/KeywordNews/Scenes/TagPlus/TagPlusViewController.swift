//
//  TagPlusViewController.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/04.
//

import UIKit

import SnapKit

final class TagPlusViewController: UIViewController {
    private lazy var presenter = TagPlusPresenter(viewController: self)
    
    private lazy var tagCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        
        let inset: CGFloat = 16.0
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        layout.sectionInset = UIEdgeInsets(
            top: inset,
            left: inset*3,
            bottom: inset,
            right: inset*3
        )
        layout.minimumLineSpacing = inset
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            TagPlusCollectionViewCell.self,
            forCellWithReuseIdentifier: TagPlusCollectionViewCell.identifier
        )
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension TagPlusViewController: TagPlusProtocol {
    func setupNavigationBar() {
        navigationItem.title = "Tag"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
