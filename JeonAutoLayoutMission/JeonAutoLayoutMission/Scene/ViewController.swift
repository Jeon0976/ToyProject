//
//  ViewController.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

class ViewController: UIViewController {
    let topView = TopView()
    let bottomView = BottomView()
    let entryButton = EntryButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLayout()
        makeAttribute()

        topDataBinding()
        bottomDataBinding()
    }
}

