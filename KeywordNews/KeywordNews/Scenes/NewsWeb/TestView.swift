//
//  TestView.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/15.
//

import UIKit

import SnapKit

final class TestView: UIViewController {
    private lazy var button: UIButton = {
       let button = UIButton()
        
        button.setTitle("선택", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func didButton() {
        let view = NewsListViewController()
        
        navigationController?.pushViewController(view, animated: true)
    }
}
