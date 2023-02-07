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
    func clickedSelect()
    func clickedCancel()
}

/// 선택, 삭제 로직 구현
enum RightBarButtomMode {
    case select
    case delete
}

final class TagPlusPresenter: NSObject {
    private weak var viewController: TagPlusProtocol?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var tags: [Tags] = []
    
    private var mode: RightBarButtomMode = .select
    
    private var deleteTags: [Tags] = []
        
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
    
    func viewWillAppear() {
        tags = userDefaultsManager.getTags()
        print(deleteTags)
    }
    
    func didSelectButtonClicked() {
        switch mode {
        case .select:
            viewController?.clickedSelect()
            mode = .delete
        case .delete:
            viewController?.reloadCollectionView()
            viewController?.clickedCancel()
            mode = .select
        }
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
        switch mode {
        case .select:
            print(tags[indexPath.row])
        case .delete:
            let cell = collectionView.cellForItem(at: indexPath) as? TagPlusCollectionViewCell
            cell?.clicked()
            let tag = tags[indexPath.row]
            deleteTags.append(tag)
        }
    }
}

extension TagPlusPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int
    ) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagPlusCollectionViewCell.identifier,
                                                      for: indexPath
        ) as? TagPlusCollectionViewCell
        
        let tag = tags[indexPath.row]
        
        cell?.setup(tag: tag)
        cell?.cancel()
        
        return cell ?? UICollectionViewCell()
    }
}
