//
//  EntryButton.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

final class EntryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 8
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
    }
}
