//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/19.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol {
    func setUpNavigationBar()
    func setUpViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
    func presentToDetailViewController()
}

// protocol의 AnyObject와
// weak var delegate: delegate 선언 관련
protocol ReviewListDelegate {
    func selectedBook(_ bookReview: BookReview)
}

final class ReviewListPresenter:NSObject {
    private let viewController: ReviewListProtocol
    private let userDefaultsManager : UserDefaultsManagerProtocol
        
    private var review: [BookReview] = []
    
    var delegate: ReviewListDelegate?
    
    init(viewController: ReviewListProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
//         delegate : ReviewListDelegate
    ) {
        self.viewController = viewController
//        self.delegate = delegate
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController.setUpNavigationBar()
        viewController.setUpViews()
    }
    
    func viewWillAppear() {
        // TODO: UserDefaults 내용 업데이트
        review = userDefaultsManager.getReviews()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToReviewWriteViewController()
    }
    
}


extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = review[indexPath.row]
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.contents
        cell.imageView?.kf.setImage(with: review.imageURL, placeholder: .none) { _ in
            cell.setNeedsLayout()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let review = review[indexPath.row]
        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
            userDefaultsManager.deleteReviews(review)
            self.review = userDefaultsManager.getReviews()
            viewController.reloadTableView()
        }
    }
}

extension ReviewListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let review = review[indexPath.row]
        viewController.presentToDetailViewController()
        delegate?.selectedBook(review)
    }
}


