//
//  ViewController.swift
//  practiceAutoLayout
//
//  Created by 전성훈 on 2023/05/08.
//

import UIKit

class ViewController: UIViewController {
    
    var button = UIButton()
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        [button, label].forEach {
            view.addSubview($0)
        }
        
        button.configuration = .filled()
        button.setTitle("Test", for: .normal)
        
        label.text = "TEXT"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
        ])
        

    }


}

