//
//  TagPlusPresenter.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/04.
//

// MARK: 삭제 기능 구현 -> trash 버튼 눌러서 (UserDefaults 연동) / 선택 삭제 시 추가 버튼 비활성화
import UIKit

protocol TagPlusProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func reloadCollectionView()
    func makeAlertController()
    func clickedSelect()
    func clickedCancel()
    func tagPlusButtonEnable(_ value: Bool)
    func deleteCell(_ indexPath: [IndexPath])
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
    
    private var deleteTags: [IndexPath: Tags] = [:]
    
    private var deleteTagsProcess: [Tags] = []
    
    private var deleteIndexPath: [IndexPath] = []
    
    private var tagIndexPath: [IndexPath: Bool] = [:]
        
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
    }
    
    func didSelectButtonClicked() {
        switch mode {
        case .select:
            viewController?.clickedSelect()
            viewController?.tagPlusButtonEnable(false)
            mode = .delete
        case .delete:
            viewController?.reloadCollectionView()
            viewController?.clickedCancel()
            viewController?.tagPlusButtonEnable(true)
            mode = .select
        }
    }
    
    func didDeleteBarButtonClicked() {
        viewController?.deleteCell(deleteIndexPath)
        // 선택 창에서 선택 취소를 위한 dictionary구조로 생성해서 기존 배열로 가공 코드 추가
        for (_, value) in deleteTags {
            deleteTagsProcess.append(value)
        }
        userDefaultsManager.deleteTags(deleteTagsProcess)
        deleteIndexPath.removeAll()
        deleteTags.removeAll()
        tags = userDefaultsManager.getTags()
        viewController?.clickedCancel()
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
            break
        case .delete:
            if tagIndexPath[indexPath] == true {
                let cell = collectionView.cellForItem(at: indexPath) as? TagPlusCollectionViewCell
                cell?.clicked(false)
                tagIndexPath.updateValue(false, forKey: indexPath)
                deleteTags.removeValue(forKey: indexPath)
                deleteIndexPath = deleteIndexPath.filter { $0 != indexPath }
            } else {
                let cell = collectionView.cellForItem(at: indexPath) as? TagPlusCollectionViewCell
                cell?.clicked(true)
                let tag = tags[indexPath.row]
                tagIndexPath.updateValue(true, forKey: indexPath)
                deleteTags.updateValue(tag, forKey: indexPath)
                deleteIndexPath.append(indexPath)
            }
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
        cell?.clicked(false)
        
        return cell ?? UICollectionViewCell()
    }
}
