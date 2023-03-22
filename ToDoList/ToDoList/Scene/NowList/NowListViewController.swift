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
    
    let tableView = UITableView()
    let makeTodoList = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: NowListViewModel) {
        let dataSource = RxTableViewSectionedReloadDataSource<Task>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: NowListCellView.identifier, for: indexPath) as? NowListCellView
                cell?.setData(item)
                
                return cell ?? UITableViewCell()
            })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        viewModel.datas.asDriver()
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        makeTodoList.rx.tap
            .bind(to: viewModel.makeTodoListButtonTapped)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: viewModel.todoSelected)
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

typealias Alert = (title: String, message: String?)
extension Reactive where Base: NowListViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default) { _ in
                if alertController.textFields?[0].text == "" {return}
                guard let text = alertController.textFields?[0].text else {return}
                
            }
            
            alertController.addTextField { textField in
                textField.placeholder = "할 일을 작성하세요."
            }
        }
    }
}
