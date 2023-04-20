//
//  MenuItemTableViewCell.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/19.
//

import UIKit

import SnapKit

protocol MenuItemTableViewCellDelegate {
    func clickButton(_ value: Int, _ id: UUID?)
}

final class MenuItemTableViewCell: UITableViewCell {
    static let Identifier = "MenuItemTableViewCell"
    
    let title = UILabel()
    let count = UILabel()
    let price = UILabel()
    
    let plusButton = UIButton()
    let minusButton = UIButton()
    
//    let onChange: ((Int) -> Void)? = nil
    var delegate: MenuItemTableViewCellDelegate?
// 받은 UUID 값을 확인
    var id: UUID?
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        plusButton.addTarget(self, action: #selector(clickPlus), for: .touchUpInside)
//        minusButton.addTarget(self, action: #selector(clickMinus), for: .touchUpInside)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func makeCell(_ title: String, _ price: String, _ count: String) {
        self.title.text = title
        self.price.text = price
        self.count.text = count
    }
    
    func makeLayout() {
        layout()
        attribute()
    }
    
    
    @objc func clickPlus() {
        delegate?.clickButton(1, id)
        print("TEST")
    }
    
    @objc func clickMinus() {
        delegate?.clickButton(-1, id)
    }
    
    // MARK: 초기 UI Attribute 설정
    private func attribute() {
        plusButton.addTarget(self, action: #selector(clickPlus), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(clickMinus), for: .touchUpInside)
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
        [plusButton,minusButton,title,price,count].forEach { addSubview($0) }
        
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
