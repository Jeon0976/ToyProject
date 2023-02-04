//
//  NewsWebViewController.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/02.
//

import UIKit
import WebKit

import SnapKit

final class NewsWebViewController: UIViewController {
    private let webView = WKWebView()
    
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupWebView()
    }
}

private extension NewsWebViewController {
    func setupNavigationBar() {
        navigationItem.title = "Article Title"
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: "http://www.naver.com") else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = "News Link"
    }
}
