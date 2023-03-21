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
    let makeTodoList = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: NowListViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tableView, row, data in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: NowListCellView.identifier,
                    for: IndexPath(row: row, section: 0)
                ) as? NowListCellView
                
                cell?.bind(viewModel.nowListCellModel)
                cell?.todoText.text = data
                return cell ?? UITableViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        navigationItem.title = "Test"
        
        view.backgroundColor  = .systemBackground
        
        makeTodoList.title = "추가"
        makeTodoList.style = .done
        
        navigationItem.setRightBarButton(makeTodoList, animated: true)
        
        tableView.backgroundColor = .white
        tableView.separatorColor = .systemGray6
        tableView.separatorStyle = .singleLine
        
        tableView.register(NowListCellView.self, forCellReuseIdentifier: NowListCellView.identifier)
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
