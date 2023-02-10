//
//  WritePresenter.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/10.
//

import UIKit

protocol WriteProtocol: AnyObject {
    func setupView()
    func dismissView()
    func setRightBarButton(isEnabled: Bool)
}

final class WritePresenter: NSObject {
    private weak var viewController: WriteProtocol?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(viewController: WriteProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setupView()
    }
    
    func didTapLeftBarButtonItem() {
        viewController?.dismissView()
    }
    
    func didTapRightBarButtonItem(text: String) {
        let tweet = Tweet(user: User.shared, contents: text)
        userDefaultsManager.setTweet(tweet)
        viewController?.dismissView()
    }
}

extension WritePresenter: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard textView.textColor != .secondaryLabel && textView.text != nil else { return }
            
        viewController?.setRightBarButton(isEnabled: !textView.text.isEmpty)
    }
}
