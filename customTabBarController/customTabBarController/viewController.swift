//
//  viewController.swift
//  customTabBarController
//
//  Created by 전성훈 on 2023/11/01.
//

import UIKit

final class TestViewController: UIViewController {
    var number = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
