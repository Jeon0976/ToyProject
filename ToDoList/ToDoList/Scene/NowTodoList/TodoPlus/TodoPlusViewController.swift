//
//  TodoPlusViewController.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/23.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class TodoPlusViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: TodoPlusViewModel) {
        
    }
    
    private func attribute() {
        view.backgroundColor = .systemGray4
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "작업 추가"
    }
    
    private func layout() {
        
    }
}
