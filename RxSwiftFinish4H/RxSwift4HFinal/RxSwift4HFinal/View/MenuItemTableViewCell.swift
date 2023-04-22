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
    
    
    // init 내부에서 수정할 예정이라 let으로 설정해도 문제 없음.
    // 처음 데이터를 내보낼 때 클로저형식을 내보냈는데 RxSwift를 쓰면 클로저형식에서 return 형식으로 바꿀 수 있음
    private let onCountChanged: (Int) -> Void
    
    var disposeBag = DisposeBag()
    
    var title = UILabel()
    var count = UILabel()
    var price = UILabel()
    
    var plusButton = UIButton()
    var minusButton = UIButton()
    
    let onChanged: Observable<Int>
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // 1. onCountChanged 클로저 형식을 받을 PublishSubject 생성
        // 2. onCountChanged 형식은 changing.onNext
        // 3. onChanged의 Observable 형식으로 변경
        let changing = PublishSubject<Int>()
        onCountChanged = { changing.onNext($0) }

        onChanged = changing.asObservable()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func makeLayout() {
        layout()
        attribute()
    }

    func makeValue(_ title:String, _ count: String, _ price: String) {
        self.title.text = title
        self.count.text = count
        self.price.text = price
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
        plusButton.addTarget(self, action: #selector(plus), for: .touchUpInside)
        
        
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.tintColor = .systemGray
        minusButton.addTarget(self, action: #selector(minus), for: .touchUpInside)
    }
    
    @objc func plus() {
        onCountChanged(1)
    }
    
    @objc func minus() {
        onCountChanged(-1)
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
