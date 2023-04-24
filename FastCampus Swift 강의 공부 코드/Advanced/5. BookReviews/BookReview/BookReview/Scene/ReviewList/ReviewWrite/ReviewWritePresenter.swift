//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/20.
//

import UIKit

protocol ReviewWriteProtocol {
    func setUpNavigationBar()
    func showCloseAlertController()
    func close()
    func setUpViews()
    func presentToSearchBookViewController()
    func updateViews(_ book : Book)
}

final class ReviewWritePresenter: NSObject {
    private let viewController : ReviewWriteProtocol
    private let userDefaultsManager : UserDefaultsManagerProtocol
    
    private var book: Book?
    
    var bookReview: BookReview?
    
    let contentsTextViewPlaceHolderText = "내용을 입력해주세요."
    
    init(viewController: ReviewWriteProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController.setUpNavigationBar()
        viewController.setUpViews()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton(contentsText: String?) {
        // TODO: UserDefaults에 유저가 작성한 도서리뷰를 저장하기
        guard let book = book,
              let contentsText = contentsText,
                contentsText != contentsTextViewPlaceHolderText
            else {return}
        let bookReview = BookReview(title: book.title,
                                    author: book.author ?? "",
                                    contents: contentsText,
                                    imageURL: book.imageURL)
        userDefaultsManager.setReviews(bookReview)
        viewController.close()
    }
    
    func didTapBookCheckButton() {
        viewController.presentToSearchBookViewController()
    }
    
    
// MARK: Test용
    func useForTest_MakeBook() {
        self.book = Book(title: "TestTitle", image: "TestImage", author: "TestAuthor")
    }
    
    
}

extension ReviewWritePresenter: SearchBookDelegate {
    func selectedBook(_ book: Book) {
        self.book = book

        viewController.updateViews(book)
    }
}


extension ReviewWritePresenter: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else { return }
        
        textView.textColor = .label
        textView.text = nil
    }
}

