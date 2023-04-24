//
//  DetailBookPresenter.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/26.
//

import UIKit

protocol DetailBookProtocol {
    func setUpNavigationBar()
    func setUpViews()
    func close()
    func showCloseAlertController()
    func editingTextView()
}

final class DetailBookPresenter : NSObject {
    private let viewController : DetailBookProtocol
    /// 프로토콜 선언했는데 왜 하나만 해도 되는걸까??
    /// 모든 Class에서 선언한 userDefaultsManager는 같은 protocol을 공유하는거야??
    /// UserDefaultsManagerProtocol을 선언한 UserDefaultsManager Sturct을 선언해서 여기서 protocol을 맞출 필요가 없음!
    private let userDefaultsManager : UserDefaultsManagerProtocol
    
    var textShouldBeginEditing = false
    
    var bookReview: BookReview?
    
    init(viewController: DetailBookProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func ViewDidLoad() {
        viewController.setUpNavigationBar()
        viewController.setUpViews()
    }
    
    func didTapLeftBarButton() {
        if textShouldBeginEditing == false {
            viewController.close()
        } else {
            viewController.showCloseAlertController()
        }
        
    }
    
    func didTapRightBarButton(_ text: String) {
        guard let bookReview = bookReview else {return}
        let book = BookReview(title: bookReview.title,
                                    author: bookReview.author,
                                    contents: text,
                                    imageURL: bookReview.imageURL)
        userDefaultsManager.edtingReviews(book)
        viewController.close()
    }
}


extension DetailBookPresenter : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    
        if textShouldBeginEditing == false {
            viewController.editingTextView()
            return textShouldBeginEditing
        } else { return textShouldBeginEditing }
    }
}
