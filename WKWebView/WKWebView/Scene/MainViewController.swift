//
//  MainViewController.swift
//  WKWebView
//
//  Created by 전성훈 on 2023/01/27.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    private lazy var presenter = MainViewPresenter(viewController: self)
    
    private lazy var searchLabel: UILabel = {
       let label = UILabel()
        label.text = "Google Search"
        label.font = .systemFont(ofSize: 24.0, weight: .semibold, width: .standard)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색어를 입력하세요."
        
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.configuration = .filled()
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    /// 빈 화면 터치시 키보드 내려가기 구현
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

private extension MainViewController {
    @objc func didTapButton() {
        presenter.didTapButton()
    }
}

extension MainViewController: MainViewProtocol {
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
    }
    
    func setupLayout() {
        [searchLabel, searchTextField, searchButton]
            .forEach {
                view.addSubview($0)
            }
        
        searchLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
    }
    
    func didTapSearchButton() {
        let webView = WebViewController()
        webView.search = searchTextField.text
        webView.url = "https://www.google.co.kr/search?q=%s"
        navigationController?.pushViewController(webView, animated: true)
    }
}
