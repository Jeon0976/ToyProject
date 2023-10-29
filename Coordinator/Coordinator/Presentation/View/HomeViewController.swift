//
//  HomeViewController.swift
//  Coordinator
//
//  Created by 전성훈 on 2023/10/29.
//

import UIKit

final class HomeViewController: UIViewController {

    var didSendEventClosure: ((HomeViewController.Event) -> Void)?
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Home", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8.0
        btn.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    deinit {
        print("HomePageViewController deinit")
    }

    private func setupView() {
        view.backgroundColor = .white
        
        [
            loginButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        didSendEventClosure?(.home)
    }
}

extension HomeViewController {
    enum Event {
        case home
    }
}
