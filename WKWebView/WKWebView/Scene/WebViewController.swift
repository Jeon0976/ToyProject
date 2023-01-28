//
//  WebViewController.swift
//  WKWebView
//
//  Created by 전성훈 on 2023/01/28.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    private let webView = WKWebView()
    
    var search: String!
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationItem.title = search
        
        actWebView()
    }
}

private extension WebViewController {
    func actWebView() {
        var components = URLComponents(string: url)!
        components.queryItems = [URLQueryItem(name: "query", value: search)]
        let request = URLRequest(url: components.url!)
        
        view = webView
        
        webView.load(request)
    }
}
