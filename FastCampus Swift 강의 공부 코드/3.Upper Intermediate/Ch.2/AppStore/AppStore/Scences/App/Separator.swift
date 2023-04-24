//
//  Separator.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/12.
//

import UIKit
import SnapKit

final class Separator : UIView {
    private lazy var separator : UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        
        return separator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
//            make.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

