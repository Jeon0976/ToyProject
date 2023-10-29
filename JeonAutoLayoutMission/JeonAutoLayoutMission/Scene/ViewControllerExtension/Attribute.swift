//
//  Attribute.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

extension ViewController {
    func makeAttribute() {
        setNavigationLeftBarButton()
        setNavigationRightBarButton()
        setBackground(.white)
        entryButton.setTitle("입장하기", for: .normal)
        entryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setNavigationLeftBarButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "Arrow - Down 2"), for: .normal)
        button.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func setNavigationRightBarButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "Upload"), for: .normal)
        button.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func navigationButtonTapped() {
        print("navigationButtonTapped")
    }
    
    private func setBackground(_ settingColor: UIColor) {
        view.backgroundColor = settingColor
        topView.backgroundColor = settingColor
        bottomView.backgroundColor = settingColor
    }
    
    @objc func buttonTapped() {
        print("buttonTapped")
        
        let from = "빡코딩"
        let beforeTime = "22시간 전"
        let icon = UIImage(named: "Group 48095722")!
        
        let test = MessageFromWho(userIcon: icon, from: from, beforeTime: beforeTime)
        
        bottomView.updateShapshot(test)
    }
}
