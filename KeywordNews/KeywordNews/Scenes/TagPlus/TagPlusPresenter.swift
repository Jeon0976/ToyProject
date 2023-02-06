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
    
    private var tags: [Tags] = []
    
    init(viewController: TagPlusProtocol,
         tags: [Tags],
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.tags = tags
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
    
    func tagText(_ value: String) {
        let tag = Tags(tag: value)
        userDefaultsManager.setTags(tag)
        tags = userDefaultsManager.getTags()
        viewController?.reloadCollectionView()
    }
    
}

extension TagPlusPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            let tag = tags[indexPath.row]
            print(tag)

    }
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
