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
    
    private func setTopViewData(_ topModel: TopModel) {
        
    }
    
    private func setBottomViewData(_ bottomModel: BottomModel) {
        
    }
}
