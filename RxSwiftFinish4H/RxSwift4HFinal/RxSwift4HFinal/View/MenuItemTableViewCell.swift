//
//  MenuItemTableViewCell.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class MenuItemTableViewCell: UITableViewCell {
    static let identifier = "MenuItemTableViewCell"

    var title = UILabel()
    var count = UILabel()
    var price = UILabel()
    
    var plusButton = UIButton()
    var minusButton = UIButton()
    
    var onChange: ((Int) -> Void)?
    
    func makeLayout() {
        layout()
        attribute()
    }
    
    // MARK: 초기 UI Attribute 설정
    private func attribute() {
        count.font = .systemFont(ofSize: 16, weight: .light)
        count.textColor = .systemIndigo
        
        price.font = .systemFont(ofSize: 16, weight: .regular)
        price.textColor = .systemGray
        
        title.font = .systemFont(ofSize: 20, weight: .medium)
        
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .systemGray
        
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.tintColor = .systemGray
    }
    
    // MARK: Layout 설정
    private func layout() {
        [
            plusButton,
            minusButton,
            title,
            price,
            count
        ].forEach { contentView.addSubview($0) }
        
        plusButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.left.equalToSuperview().inset(16)
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.left.equalTo(plusButton.snp.right).offset(8)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.left.equalTo(minusButton.snp.right).offset(32)
        }
        
        price.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.right.equalToSuperview().inset(16)
        }
        
        count.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.left.equalTo(title.snp.right).offset(8)
        }
    }

}
