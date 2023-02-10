//
//  WriteViewController.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/10.
//

import UIKit

import SnapKit

final class WriteViewController: UIViewController {
    private lazy var presenter = WritePresenter(viewController: self)
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        button.title = "닫기"
        button.style = .plain
        button.target = self
        button.action = #selector(didTapLeftBarButtonItem)
        
        return button
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        button.title = "트윗"
        button.style = .plain
        button.target = self
        button.action = #selector(didTapRightBarButtonItem)
        button.isEnabled = false
        
        return button
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.delegate = presenter
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.text = "피드를 입력하세요"
        textView.textColor = .secondaryLabel
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        textView.layer.borderWidth = 0.8
        textView.layer.cornerRadius = 15
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension WriteViewController: WriteProtocol {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(textView)
        
        let margin: CGFloat = 16.0
        
        textView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(margin)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(margin)
            $0.height.equalTo(160.0)
        }
    }
    
    func dismissView() {
        dismiss(animated: true)
    }
    
    func setRightBarButton(isEnabled: Bool) {
        rightBarButtonItem.isEnabled = isEnabled
    }
}

private extension WriteViewController {
    @objc func didTapLeftBarButtonItem() {
        presenter.didTapLeftBarButtonItem()
    }
    
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem(text: textView.text)
    }
}
