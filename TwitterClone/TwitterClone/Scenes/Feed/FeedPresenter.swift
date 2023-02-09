//
//  FeedPresenter.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import UIKit

protocol FeedProtocol: AnyObject {
    func setupView()
}

final class FeedPresenter:NSObject {
    private weak var viewController: FeedProtocol?
    
    init(viewController: FeedProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
    }
}

extension FeedPresenter: UITableViewDelegate {
    
}

extension FeedPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}
