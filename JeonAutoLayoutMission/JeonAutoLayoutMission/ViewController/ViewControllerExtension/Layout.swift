//
//  Layout.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

extension ViewController {
    func makeLayout() {
        [
            topView,
            bottomView,
            entryButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // topView
            topView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            topView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            topView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            
            // bottomView
            bottomView.topAnchor.constraint(
                equalTo: topView.bottomAnchor,
                constant: 20
            ),
            bottomView.leadingAnchor.constraint(
                equalTo: topView.leadingAnchor
            ),
            bottomView.trailingAnchor.constraint(
                equalTo: topView.trailingAnchor
            ),
            
            // entryButton
            entryButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            ),
            entryButton.leadingAnchor.constraint(
                equalTo: topView.leadingAnchor
            ),
            entryButton.trailingAnchor.constraint(
                equalTo: topView.trailingAnchor
            )
            
        ])
    }
}
