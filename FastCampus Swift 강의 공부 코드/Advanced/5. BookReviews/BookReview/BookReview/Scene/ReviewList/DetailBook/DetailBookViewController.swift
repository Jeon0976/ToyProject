//
//  DetailBookViewController.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/26.
//

import UIKit
import SnapKit
import Kingfisher


class DetailBookViewController: UIViewController {
    private lazy var presenter = DetailBookPresenter(viewController: self)
    
    private lazy var bookTitleButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        
        return button
    }()
    
    private lazy var authorButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .bold)
        
        return button
    }()
        
    private lazy var contentTextView: UITextView = {
       let textView = UITextView()
        textView.textColor = .label
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = presenter
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.ViewDidLoad()
    }
}

extension DetailBookViewController : DetailBookProtocol {
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(didTapLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(didTapRightBarButton))
    }
    
    
    func setUpViews() {
        view.backgroundColor = .systemBackground
        [bookTitleButton,authorButton,contentTextView,imageView].forEach { view.addSubview($0) }
        
        bookTitleButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
        
        authorButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16.0)
        }
        
        contentTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(authorButton.snp.bottom).offset(16.0)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalTo(contentTextView.snp.leading)
            $0.trailing.equalTo(contentTextView.snp.trailing)
            $0.top.equalTo(contentTextView.snp.bottom).offset(16.0)
            $0.height.equalTo(200.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func close() {
        self.dismiss(animated: true)
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?",
                                                message: nil,
                                                preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기",
                                        style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [closeAction,cancelAction].forEach { alertController.addAction($0)}
        present(alertController, animated: true)
    }
    
    func editingTextView() {
        let alertController = UIAlertController(title: "내용을 수정하시겠습니까?",
                                                message: nil,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel) { [weak self] _ in
            self?.presenter.textShouldBeginEditing = false
        }
        let modifyAction = UIAlertAction(title: "수정", style: .destructive) { [weak self] _ in
            self?.presenter.textShouldBeginEditing = true
        }
        [cancelAction,modifyAction].forEach { alertController.addAction($0) }
        present(alertController, animated: true)
    }
    
}

extension DetailBookViewController : ReviewListDelegate {
    func selectedBook(_ bookReview: BookReview) {
        presenter.bookReview = bookReview
        bookTitleButton.setTitle(bookReview.title, for: .normal)
        authorButton.setTitle(bookReview.author, for: .normal)
        imageView.kf.setImage(with: bookReview.imageURL)
        contentTextView.text = bookReview.contents
    }
}

private extension DetailBookViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton(contentTextView.text)
    }
}
