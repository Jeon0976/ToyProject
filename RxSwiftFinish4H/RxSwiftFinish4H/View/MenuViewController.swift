//
//  MenuViewController.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit


class MenuViewController: UIViewController {
    
    let viewModel: MenuViewModelType
    let disposeBag = DisposeBag()
    
    
    let titleLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView(style: .large)

    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    
    let numberView = UIView()
    let itemCountLabel = UILabel()
    let item = UILabel()
    let totalPrice = UILabel()
    let yourOrders = UILabel()
    let clearButton = UIButton()
    
    let bottomView = UIView()
    let orderButton = UIButton()
    
    init(viewModel: MenuViewModelType = MenuViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        attribute()
        layout()
    }

    func bind() {
        
    }
    
    private func attribute() {
        view.backgroundColor = .systemBackground
        
        titleLabel.text = "Bear Fride Center"
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        activityIndicator.color = .black
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
                
        numberView.backgroundColor = .systemGray4
        
        yourOrders.text = "Your Orders"
        yourOrders.font = .systemFont(ofSize: 15, weight: .bold)

        clearButton.setTitle("Clear", for: .normal)
        clearButton.tintColor = .white
        
        itemCountLabel.text = "0"
        item.text = "Items"
        
        orderButton.setTitle("ORDER", for: .normal)
        orderButton.tintColor = .white
        
        bottomView.backgroundColor = .black
    }
    
    func layout() {
        [titleLabel,activityIndicator,tableView,numberView,itemCountLabel,item,totalPrice,yourOrders,clearButton,bottomView,orderButton].forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.left.equalTo(titleLabel.snp.right).offset(16.0)
        }
    }
}

