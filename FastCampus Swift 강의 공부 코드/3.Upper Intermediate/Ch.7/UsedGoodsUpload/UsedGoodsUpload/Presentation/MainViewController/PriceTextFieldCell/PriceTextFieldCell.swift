//
//  PriceTextFieldCell.swift
//  UsedGoodsUpload
//
//  Created by 전성훈 on 2022/11/04.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PriceTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    let priceInputField = UITextField()
    
    let freeshareButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PriceTextFieldCellViewModel) {
        viewModel.showFreeShareButton
        // ex) true 값이 들어오면 false로 mapping해서 isHidden값에 반영
            .map{ !$0 }
            .emit(to: freeshareButton.rx.isHidden)
            .disposed(by: disposeBag)
            
        viewModel.resetPrice
            .map { _ in "" }
            .emit(to: priceInputField.rx.text)
            .disposed(by: disposeBag)
        
        priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: disposeBag)
        
        freeshareButton.rx.tap
            .bind(to: viewModel.freeShareButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        freeshareButton.setTitle("무료나눔", for: .normal)
        freeshareButton.setTitleColor(.orange, for: .normal)
        freeshareButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        freeshareButton.titleLabel?.font = .systemFont(ofSize: 18)
        // tintColor -> 버튼 내부의 아이콘 색??
        freeshareButton.tintColor = .orange
        freeshareButton.layer.borderWidth = 1
        freeshareButton.layer.cornerRadius = 10
        freeshareButton.backgroundColor = .white
        freeshareButton.layer.borderColor = UIColor.orange.cgColor
        freeshareButton.isHidden = true
        // 이미지와 텍스트간의 위치
        freeshareButton.semanticContentAttribute = .forceLeftToRight
        
        priceInputField.keyboardType = .numberPad
        priceInputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        [priceInputField,freeshareButton].forEach {
            contentView.addSubview($0)
        }
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        freeshareButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }
}
