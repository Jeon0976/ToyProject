//
//  NowListViewController.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/20.
//

import UIKit

import RxSwift
import RxCocoa

final class NowListViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: NowListViewModel) {
        print("TestNow")
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
    }
}
