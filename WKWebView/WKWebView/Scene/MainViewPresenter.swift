//
//  MainViewPresenter.swift
//  WKWebView
//
//  Created by 전성훈 on 2023/01/28.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setupView()
    func setupLayout()
    func didTapSearchButton()
}

final class MainViewPresenter: NSObject {
    private weak var viewController: MainViewProtocol?
    
    init(viewController: MainViewProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
        viewController?.setupLayout()
    }
}
