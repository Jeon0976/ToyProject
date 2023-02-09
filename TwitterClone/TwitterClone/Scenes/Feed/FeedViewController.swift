//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import UIKit

final class FeedViewControler: UIViewController {
    private lazy var presenter = FeedPresenter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension FeedViewControler: FeedProtocol {
    func setupLayout() {
        
    }
}
