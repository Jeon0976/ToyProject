//
//  ReviewWriteViewController.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/20.
//

import UIKit
import SnapKit
import Kingfisher

final class ReviewWriteViewController : UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)
        
    private lazy var bookTitleButton: UIButton = {
       let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        // 왼쪽 정렬
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        button.addTarget(self, action: #selector(didTapBookCheckButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var authorButton: UIButton = {
       let button = UIButton()
        button.setTitle("저자 이름", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .bold)
        button.addTarget(self, action: #selector(didTapBookCheckButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = presenter.contentsTextViewPlaceHolderText
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = presenter
        
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        // clipsToBounds??
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension ReviewWriteViewController : ReviewWriteProtocol {
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
        [bookTitleButton, authorButton,contentTextView, imageView].forEach {view.addSubview($0)}
        
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
        if bookTitleButton.titleColor(for: .normal) == .tertiaryLabel {
            self.dismiss(animated: true)
        } else {
            present(alertController, animated: true)
        }
    }
    
    func close() {
        self.dismiss(animated: true)

    }
    
    func presentToSearchBookViewController() {
        let vc = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        present(vc, animated: true)
    }
    
    func updateViews(_ book : Book) {
        print(book)
        bookTitleButton.setTitle(book.title, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        authorButton.setTitle(book.author, for: .normal)
        authorButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: book.imageURL)
        contentTextView.text = nil
    }
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton(contentsText: contentTextView.text)
    }
    
    @objc func didTapBookCheckButton() {
        presenter.didTapBookCheckButton()
    }
}

