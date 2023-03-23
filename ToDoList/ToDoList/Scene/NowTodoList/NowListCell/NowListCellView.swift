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
    let todoCheckImageView = UIImageView()
    
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
    
    func setData(_ todo: TodoList) {
        switch todo.isDone {
        case true:
            todoCheckImageView.image = UIImage(systemName: "checkmark.circle.fill")
            todoText.text = todo.todo
        case false:
            todoCheckImageView.image = UIImage(systemName: "circle")
            todoText.text = todo.todo
        }
    }
    
    private func attribute() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    private func layout() {
//        contentView.layer.cornerRadius = 10
        
        [todoText, todoCheckImageView].forEach {
            contentView.addSubview($0)
        }
        
        todoCheckImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview().inset(16.0)
        }
        
        todoText.snp.makeConstraints {
            $0.leading.equalTo(todoCheckImageView.snp.trailing).offset(16.0)
            $0.top.bottom.equalToSuperview().inset(16.0)
        }
    }
}
