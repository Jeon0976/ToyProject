//
//  MainViewController.swift
//  WKWebView
//
//  Created by 전성훈 on 2023/01/27.
//

import UIKit

import SnapKit

// MARK: Naver, Google 검색 변경 기능 추가
/// 기능 구현간 구조체 및 string 값 presenter에 구현해야하나? 아님 viewController에 구현해야하나
/// viewPresenter에 적절하게 구현될 것은 무엇일까
/// alert 설정에서 if, else 구문 대신 쓸수 있는 조건은?? 함수로 구현해서?? 설정??
/// alert 설정간 클로저에서 순한참조가 일어나지 않는다??
/// https://nsios.tistory.com/62
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
    
    // "검색" -> 돋보기 아이콘으로 변경
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.configuration = .filled()
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    /// 검색할 포털사이트 설정하기 구현
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "globe.central.south.asia.fill"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButton))
    
    var searchAddress = SearchEngine().google
    
    override func viewDidLoad() {
        print("super presenter \(CFGetRetainCount(self))")

        super.viewDidLoad()
        print("before presenter \(CFGetRetainCount(self))")
        presenter.viewDidLoad()
        print("after presenter \(CFGetRetainCount(self))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear \(CFGetRetainCount(self))")
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
    
    @objc func didTapRightBarButton() {
        presenter.didTapChangeSearchEngineButton()
    }
}

extension MainViewController: MainViewProtocol {
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationItem.rightBarButtonItem = rightBarButtonItem
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
            $0.top.equalTo(searchLabel.snp.bottom).offset(32.0)
            $0.leading.equalToSuperview().inset(96.0)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(32.0)
            $0.leading.equalTo(searchTextField.snp.trailing).offset(16.0)
        }
    }
    
    func didTapSearchButton() {
        let webView = WebViewController()
        webView.search = searchTextField.text
        webView.url = searchAddress
        navigationController?.pushViewController(webView, animated: true)
    }
    
    func didTapChangeSearchEngineButton() {
        let alert = UIAlertController(title: "Search Engine", message: nil, preferredStyle: .actionSheet)
        let google = UIAlertAction(title: "Google", style: .default) { _ in
            print("init \(CFGetRetainCount(self))")

            self.searchLabel.text = "Google Search"
            self.searchAddress = SearchEngine().google
        }
        let naver = UIAlertAction(title: "Naver", style: .default) { _ in
            self.searchLabel.text = "Naver Search"
            self.searchAddress = SearchEngine().naver
        }
        [google, naver]
            .forEach {
                alert.addAction($0)
            }
        present(alert, animated: true)
    }

}
