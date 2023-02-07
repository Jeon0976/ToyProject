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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
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
            if alertController.textFields?[0].text == "" {return}
            guard let text = alertController.textFields?[0].text else {return}
            self?.presenter.tagText(text)
        })
        alertController.addTextField { textField in
            textField.placeholder = "테그값을 입력하세요."
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func clickedSelect() {
        selectBarButton.title = "취소"
        deleteBarButton.isHidden = false
    }
    
    func clickedCancel() {
        selectBarButton.title = "선택"
        deleteBarButton.isHidden = true
    }
    
    func tagPlusButtonEnable(_ value: Bool) {
        tagPlusButton.isEnabled = value
    }
    
    func deleteCell(_ indexPath: [IndexPath]) {
        tagCollectionView.deleteItems(at: indexPath)
    }
}

private extension TagPlusViewController {

    @objc func didTapPlusButtonCliked() {
        presenter.didTapPlusButtonCliked()
    }
    
    @objc func didSelectButtonClicked() {
        presenter.didSelectButtonClicked()
    }
    
    @objc func didDeleteBarButtonClicked() {
        presenter.didDeleteBarButtonClicked()
    }
}
