//
//  viewController.swift
//  customTabBarController
//
//  Created by 전성훈 on 2023/11/01.
//

import UIKit
import SpeechBubble

final class TestViewController: UIViewController {
    var number = ""
    
    private lazy var test: SpeechBubbleView = SpeechBubbleView(text: "Test", style: .fill, arrowPosition: .left)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [
            test
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            test.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            test.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        print("\(number): ViewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("\(number): ViewWillAppear")
    }
    
    init(_ number: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.number = number
        
        print("\(number): init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(number): Deinit")
    }
}
