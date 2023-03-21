//
//  NowListCellView .swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/21.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class NowListCellView: UITableViewCell {
    static let identifier = "NowListCellView"
    
    let disposeBag = DisposeBag()
    
    let todoText = UILabel()
    let todoCheckButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: NowListCellModel) {
        
    }
    
    func textData(_ text: String) {
        todoText.text = text
    }
    
    private func attribute() {
        todoText.font = .systemFont(ofSize: 17)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .light)
        let image = UIImage(systemName: "checkmark.diamond", withConfiguration: imageConfig)
        
        todoCheckButton.setImage(image, for: .normal)
    }
    
    private func layout() {
        [todoText, todoCheckButton].forEach {
            contentView.addSubview($0)
        }
        
        todoCheckButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview().inset(16.0)
        }
        
        todoText.snp.makeConstraints {
            $0.leading.equalTo(todoCheckButton.snp.trailing).offset(16.0)
            $0.top.bottom.equalToSuperview().inset(16.0)
        }
    }
}
