//
//  TagPlusViewController.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/04.
//

import UIKit

import SnapKit

/// 선택, 삭제 로직 구현
enum RightBarButtomMode {
    case select
    case delete
}

final class TagPlusViewController: UIViewController {
    
    private var mode: RightBarButtomMode = .select
    
    private var tags: [Tags] = []
    
    private lazy var presenter = TagPlusPresenter(viewController: self, tags: tags)
    
    init(tags: [Tags]) {
        self.tags = tags
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    
    private lazy var tagPlusButton: UIButton = {
        let button = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 48, weight: .heavy)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: imageConfig)
        let simage = UIImage(systemName: "plus", withConfiguration: imageConfig)
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButtonCliked), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var selectBarButton: UIBarButtonItem = {
       let button = UIBarButtonItem()
        
        button.title = "선택"
        button.style = .plain
        button.target = self
        button.action = #selector(didSelectButtonClicked)
        
        return button
    }()
    
    private lazy var deleteBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        button.image = UIImage(systemName: "trash")
        button.target = self
        button.action = #selector(didDeleteBarButtonClicked)
        button.isHidden = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
}

extension TagPlusViewController: TagPlusProtocol {
    func setupNavigationBar() {
        navigationItem.title = "Tag"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItems = [selectBarButton, deleteBarButton]

    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        [tagCollectionView, tagPlusButton].forEach { view.addSubview($0) }
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tagPlusButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48.0)
            $0.trailing.equalToSuperview().inset(48.0)
        }
    }
    
    func reloadCollectionView() {
        tagCollectionView.reloadData()
    }
    
    func makeAlertController() {
        let alertController = UIAlertController(title: "테그 생성", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let text = alertController.textFields?[0].text else {return}
            self?.presenter.tagText(text)
        })
        // MARK: Timer 기능으로 순환참조 테스트
        alertController.addTextField { textField in
            textField.placeholder = "테그값을 입력하세요."
        }
                                        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}

private extension TagPlusViewController {

    @objc func didTapPlusButtonCliked() {
        presenter.didTapPlusButtonCliked()
    }
    
    @objc func didSelectButtonClicked() {
        switch mode {
        case.select:
            selectBarButton.title = "취소"
            deleteBarButton.isHidden = false
            tagCollectionView.allowsMultipleSelection = true
            mode = .delete
            
        case.delete:
            selectBarButton.title = "선택"
            deleteBarButton.isHidden = true
            tagCollectionView.allowsMultipleSelection = false
            mode = .select
        }
    }
    
    @objc func didDeleteBarButtonClicked() {
        presenter.didDeleteBarButtonClicked()
    }
}
