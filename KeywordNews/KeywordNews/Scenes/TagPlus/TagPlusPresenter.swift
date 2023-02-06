//
//  TagPlusPresenter.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/04.
//

import UIKit

protocol TagPlusProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func reloadCollectionView()
    func makeAlertController()
}

final class TagPlusPresenter: NSObject {
    private weak var viewController: TagPlusProtocol?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var tags: [Tags] = UserDefaultsManager().getTags()
    
    init(viewController: TagPlusProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
    
    func didDeleteBarButtonClicked() {
        
    }
    
    func didTapPlusButtonCliked() {
        viewController?.makeAlertController()
    }
}

extension TagPlusPresenter: UICollectionViewDelegateFlowLayout {
    
}

extension TagPlusPresenter: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        tags.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagPlusCollectionViewCell.identifier,
            for: indexPath
        ) as? TagPlusCollectionViewCell
        
        let tag = tags[indexPath.row]
        
        cell?.setup(tag: tag)
        
        return cell ?? UICollectionViewCell()
    }
}
