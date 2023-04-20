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


final class MenuViewController: UIViewController {
    
    var onChange: ((Int) -> Void)?
    
    
    let viewModel: MenuViewModelType
    let disposeBag = DisposeBag()
    
    // 불러온 데이터를 menu에 넣어주는데 넣어주고나서 MainSchduler에서 tableView.reload 실시
    var menus: [ViewMenu] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    let titleLabel = UILabel()
    let refreshControl = UIRefreshControl()
    let activityIndicator = UIActivityIndicatorView(style: .large)

    let tableView = UITableView(frame: .zero, style: .plain)

    
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

        // 처음 API 데이터 불러오기
        getData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        attribute()
        layout()

        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    // TODO: RxSwift 스타일로 바꾸기
    func bind() {
        orderButton.addTarget(self, action: #selector(pushOrderView), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clickClear), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func pushOrderView() {
        // 버튼 눌러짐 효과
        orderButton.setTitleColor(.gray, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.orderButton.setTitleColor(.white, for: .normal)
            let orderVC = OrderViewController()
            let orderViewModel = OrderViewModel()
            orderVC.viewModel = orderViewModel
            orderVC.selectedMenus = (self?.menus.filter { $0.count > 0 })!
            self?.navigationController?.pushViewController(orderVC, animated: true)
        }
    }
    
    @objc func clickClear() {
        // 버튼 눌러짐 효과
        clearButton.setTitleColor(.systemGray4, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.menus.indices.forEach { index in
                self?.menus[index].count = 0
            }
            self?.tableView.reloadData()
            self?.totalPrice.text = "0"
            self?.itemCountLabel.text = "0"
            self?.clearButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc func handleRefreshControl() {
        activityIndicator.isHidden = false
        
        getData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.isHidden = true
        }
    }
    
    // MARK: 초기 UI Atrribute 설정
    private func attribute() {
        view.backgroundColor = .systemBackground
        
        titleLabel.text = "Bear Fride Center"
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: MenuItemTableViewCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
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

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.Identifier, for: indexPath) as? MenuItemTableViewCell
        
        let menu = menus[indexPath.row]
        
        cell?.delegate = self
        cell?.makeLayout()
        cell?.id = menu.id
        cell?.makeCell(menu.name, String(menu.price), String(menu.count))

        return cell ?? UITableViewCell()
    }
    
}

// MARK: API 처리
extension MenuViewController {
    func getData() {
        APIService.fetchMenus { [weak self] menuItem, err in
            if let err = err {
                return print(err)
            }
            guard menuItem != nil else {
                return print("no data")
            }
            self?.menus = menuItem!.map { ViewMenu(name: $0.name, price: $0.price, count: 0)}
        }
    }
}

// MARK: Cell Delegate
extension MenuViewController: MenuItemTableViewCellDelegate {
    func clickButton(_ value: Int, _ id: UUID?) {
        if let index = menus.firstIndex(where: { $0.id == id }) {
            menus[index].count += value
            menus[index].count = max(menus[index].count, 0)
        }
        tableView.reloadData()
        itemCountLabel.text = String(menus.map { $0.count }.reduce(0, +))
        totalPrice.text = String(menus.map { $0.price * $0.count}.reduce(0, +))
    }
    
}
