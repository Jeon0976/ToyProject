//
//  LoginViewPresenter.swift
//  projectB.SignUp
//
//  Created by 전성훈 on 2023/05/12.
//

import UIKit

protocol LoginProtocol: NSObject {
    func setUpAttribute()
    func setUpLayout()
}

final class LoginViewPresenter: NSObject {
    private weak var viewController: LoginProtocol?
        
    init(viewController: LoginProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setUpAttribute()
        viewController?.setUpLayout()
    }
    
}


extension LoginViewPresenter: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
    }
}
