//
//  ViewController.swift
//  TwitterClone
//
//  Created by 전성훈 on 2023/02/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = UserDefaultsManager()
        manager.setTweet(Tweet(user: User.shared, contents: "하이!"))
        
        print(manager.getTweet())
        manager.removeTweet(Tweet(user: User.shared, contents: "하이!"))
        print(manager.getTweet())
    }
}

