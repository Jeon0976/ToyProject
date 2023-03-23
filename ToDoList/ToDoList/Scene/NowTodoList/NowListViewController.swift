//
//  NowListViewController.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/20.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class NowListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let makeTodoList = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: NowListViewModel) {
        let dataSource = RxTableViewSectionedReloadDataSource<Task>(
            configureCell: { _, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: NowListCellView.identifier,
                    for: indexPath
                ) as? NowListCellView
                cell?.setData(item)
                return cell ?? UITableViewCell()
            })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        viewModel.todoPlusViewPush
            .drive(onNext: { viewModel in
                let viewController = TodoPlusViewController()
                viewController.bind(viewModel)
                self.show(viewController, sender: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.datas.asDriver()
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: viewModel.todoSelected)
            .disposed(by: disposeBag)
        
        makeTodoList.rx.tap
            .bind(to: viewModel.makeTodoListButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "오늘 작업"
        
        view.backgroundColor  = .systemGray6

        makeTodoList.title = "추가"
        makeTodoList.style = .done
        
        navigationItem.setRightBarButton(makeTodoList, animated: true)
        
        tableView.backgroundColor = .clear
        
        tableView.register(NowListCellView.self, forCellReuseIdentifier: NowListCellView.identifier)
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
