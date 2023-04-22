//
//  ViewController.swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class MenuViewController: UIViewController {

    var disposeBag = DisposeBag()
    var viewModel: MenuViewModelType
    
    var titleLabel = UILabel()
    var refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView(style: .large)

    var tableView = UITableView(frame: .zero, style: .plain)

    var numberView = UIView()
    var itemCountLabel = UILabel()
    var item = UILabel()
    var totalPrice = UILabel()
    var yourOrders = UILabel()
    var clearButton = UIButton()
    
    var bottomView = UIView()
    var orderButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        attribute()
        layout()
        
        bind()
    }
    
    init(viewModel: MenuViewModelType = MenuViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Binding
    func bind() {
        // TableView 그리기
        viewModel.menus
            .bind(to: tableView.rx.items(
                cellIdentifier: MenuItemTableViewCell.identifier,
                cellType: MenuItemTableViewCell.self)
            ) { _, element, cell in
                cell.makeLayout()
                cell.makeValue(element.name, String(element.count),element.price.currencyKR())
                
                // cell 내부 Observable dispose
                cell.onChanged
                    .map { (element, $0) }
                    .bind(to: self.viewModel.increaseCount)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // ViewModel에서 View totalCount 변경
        viewModel.totalCount
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // ViewModel에서 View totalPrice 변경
        viewModel.totalPrice
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
        
        
        // view에서 viewModel로 order 클릭 시
        viewModel
    }
    
    // MARK: 초기 UI Atrribute 설정
    private func attribute() {
        view.backgroundColor = .systemBackground
        
        titleLabel.text = "Bear Fride Center"
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
        // 클릭 무시
        tableView.allowsSelection = false
        tableView.refreshControl = refreshControl
        
        numberView.backgroundColor = .systemGray4
        
        yourOrders.text = "Your Orders"
        yourOrders.font = .systemFont(ofSize: 18, weight: .bold)

        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        
        itemCountLabel.text = "0"
        itemCountLabel.font = .systemFont(ofSize: 18, weight: .bold)
        itemCountLabel.textColor = .systemIndigo
        
        item.text = "Items"
        item.font = .systemFont(ofSize: 18, weight: .light)
        item.textColor = .systemIndigo
        
        totalPrice.text = "0"
        totalPrice.font = .systemFont(ofSize: 42, weight: .heavy)
        
        orderButton.setTitle("ORDER", for: .normal)
        orderButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        orderButton.setTitleColor(.white, for: .normal)
        
        bottomView.backgroundColor = .black
    }
    
    // MARK: Layout 설정
    func layout() {
        [
            titleLabel,
            activityIndicator,
            tableView,
            numberView,
            itemCountLabel,
            item,
            totalPrice,
            yourOrders,
            clearButton,
            bottomView,
            orderButton
        ].forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16.0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        numberView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.bottom.equalTo(bottomView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        yourOrders.snp.makeConstraints {
            $0.top.equalTo(numberView.snp.top).inset(16)
            $0.leading.equalTo(numberView.snp.leading).inset(16)
        }
        
        clearButton.snp.makeConstraints {
            $0.top.equalTo(yourOrders.snp.top).inset(-5)
            $0.leading.equalTo(yourOrders.snp.trailing).offset(16)
        }
        
        itemCountLabel.snp.makeConstraints {
            $0.top.equalTo(yourOrders.snp.top)
        }
        
        item.snp.makeConstraints {
            $0.top.equalTo(yourOrders.snp.top)
            $0.trailing.equalTo(numberView.snp.trailing).inset(16)
            $0.leading.equalTo(itemCountLabel.snp.trailing).offset(8)
        }
        
        totalPrice.snp.makeConstraints {
            $0.trailing.equalTo(numberView.snp.trailing).inset(16)
            $0.bottom.equalTo(numberView.snp.bottom).inset(8)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        orderButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bottomView.snp.top).inset(6)
        }
    }
}
