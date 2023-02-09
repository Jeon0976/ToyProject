//
//  FeedPresenter.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import UIKit

protocol FeedProtocol: AnyObject {
    func setupLayout()
}

final class FeedPresenter {
    private weak var viewController: FeedProtocol?
    
    init(viewController: FeedProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupLayout()
    }
}
