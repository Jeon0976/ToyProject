//
//  OrderViewController.swift
//  RxSwiftFinish4H
//
//  Created by 전성훈 on 2023/04/19.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class OrderViewController :UIViewController {
    
    var viewModel: OrderViewModelType
    let disposeBag = DisposeBag()
    
    let titleOrdered = UILabel()
    let orderedItems = UILabel()
    let priceToPay = UILabel()
    let items = UILabel()
    let vat = UILabel()
    let itemsPrice = UILabel()
    let vatPrice = UILabel()
    let separator = UIView()
    let totalPrice = UILabel()
    
    
    init(viewModel: OrderViewModelType = OrderViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func bind() {
        
    }
    
    private func attribute() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Receipt"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes =
        [.foregroundColor: UIColor.white]
        
        
    }
    
    private func layout() {
        
    }
}
