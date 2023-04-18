//
//  OrderViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 07/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    // MARK: - Life Cycle

    var selectedMenus:[Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let totalPrice = 0
        //let vatPrice = Int(Float(allItemsPrice) * 0.1 / 10 + 0.5) * 10
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        let orderList = selectedMenus.map { "\($0.name) \($0.count)개" }.joined(separator: "\n")
        ordersList.text = orderList
        ordersListHeight.constant = ordersList.bounds.width - 30
        let price = selectedMenus.map { $0.count * $0.price }.reduce(0, +)
        let vat = 100
        itemsPrice.text = String(price)
        vatPrice.text = String(vat)
        totalPrice.text = String(vat + price)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: update selected menu info


        updateTextViewHeight()
    }

    // MARK: - UI Logic

    func updateTextViewHeight() {
//        let text = ordersList.text ?? ""
//        let width = ordersList.bounds.width
//        let font = ordersList.font ?? UIFont.systemFont(ofSize: 20)
//
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = text.boundingRect(with: constraintRect,
//                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
//                                            attributes: [NSAttributedString.Key.font: font],
//                                            context: nil)
//        let height = boundingBox.height
//
//        ordersListHeight.constant = height + 40


    }

    // MARK: - Interface Builder

    @IBOutlet var ordersList: UITextView!
    @IBOutlet var ordersListHeight: NSLayoutConstraint!
    @IBOutlet var itemsPrice: UILabel!
    @IBOutlet var vatPrice: UILabel!
    @IBOutlet var totalPrice: UILabel!
}
