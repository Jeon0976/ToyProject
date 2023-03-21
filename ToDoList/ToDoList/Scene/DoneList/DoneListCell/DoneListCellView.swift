//
//  DoneListCellView.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/21.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class DoneListCellView: UITableViewCell {
    static let identifier = "DoneListCellView"
    
    let disposeBag = DisposeBag()
    
    let todoText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DoneListCellModel) {
        
    }
    
    func textData(_ text: String) {
        todoText.text = "🫡  \(text)"
    }
    
    private func attribute() {
        todoText.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        contentView.addSubview(todoText)
        
        todoText.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
}
