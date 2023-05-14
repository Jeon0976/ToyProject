//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by 전성훈 on 2023/02/13.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var tableView = UITableView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        tableView.register(TestTableView.self, forCellReuseIdentifier: TestTableView.identifier)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String>>(configureCell: {(_ , tableView,indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: TestTableView.identifier,for: indexPath) as! TestTableView
            cell.textLabel?.text = item
            return cell
        }, titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        })
        
        let sections = [
            SectionModel(model: "Section 1", items: ["Item 1","Item 2", "Item 3"]),
            SectionModel(model: "Section 2", items: ["Item 4","Item 5", "Item 6"]),
            SectionModel(model: "Section 3", items: ["Item 7","Item 8", "Item 9"])
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }


}



class TestTableView: UITableViewCell {
    static let identifier = "cell"
}
