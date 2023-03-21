//
//  DoneListViewController.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/20.
//

import UIKit

import RxSwift
import RxCocoa

final class DoneListViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    let titleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: DoneListViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tableView, row, data in
                let cell = tableView.dequeueReusableCell(withIdentifier: DoneListCellView.identifier, for: IndexPath(row: row, section: 0)) as? DoneListCellView
                
                cell?.bind(viewModel.doneListCellModel)
                cell?.textData(data)
                
                return cell ?? UITableViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        titleButton.setTitle("Test", for: .normal)
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        navigationItem.titleView = titleButton
        
        view.backgroundColor = .systemBackground

        tableView.backgroundColor = .white
        tableView.separatorColor = .systemGray6
        tableView.separatorStyle = .singleLine
        
        tableView.register(DoneListCellView.self, forCellReuseIdentifier: DoneListCellView.identifier)
        
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
