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
    func didTapChangeSearchEngineButton()
}

final class MainViewPresenter: NSObject {
    private weak var viewController: MainViewProtocol?
    
    init(viewController: MainViewProtocol) {
//        print("after11 presenter \(CFGetRetainCount(self))")

        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
        viewController?.setupLayout()
    }
    
    func didTapButton() {
        viewController?.didTapSearchButton()
    }
    
    func didTapChangeSearchEngineButton() {
        viewController?.didTapChangeSearchEngineButton()
    }
}
