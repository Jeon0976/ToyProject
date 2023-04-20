//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    // MARK: - Life Cycle
    
    let cellID = "MenuItemTableViewCell"
    
    let viewModel = MenuListViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.menuObservable
            .bind(to: tableView.rx.items(cellIdentifier: cellID,cellType: MenuItemTableViewCell.self)) { index, item, cell in
                
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "\(item.count)"
                
                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item, increase)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.itemsCount
            .map { "\($0)" }
        // 3
        // UI 관련 작업할 때 항상 아래 두 메서드가 필요함
        // 1. 에러 발생시 빈값 호출
        // 2. UI 변경 전, MainScheduler에서 작동
        // 하지만 2개 만들자니 복잡해져서
        // 편하게 만든 메소드 있음
            .catchErrorJustReturn("")
            .observeOn(MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
        // bind 순한 참조 신경 x
//            .subscribe(onNext: { [weak self] in
//                self?.itemCountLabel.text = $0
//            })
            .disposed(by: disposeBag)
        
        // 그 메서드가 drive임
        // 항상 메인 쓰레드에서 작동 보장
        viewModel.totalPrice
            .asDriver(onErrorJustReturn: 0)
            .map { $0.currencyKR() }
            .drive(totalPrice.rx.text)
//            .bind(to: totalPrice.rx.text )
//            .subscribe(onNext: {
//                self.totalPrice.text = $0
//            })
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
           let selectedMenus = sender as? [Menu],
            let orderVC = segue.destination as? OrderViewController {
            orderVC.selectedMenus = selectedMenus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.clearAllItemSelections()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        let selectedMenus = viewModel.onOrder()
        print(selectedMenus)
        // TODO: no selection
//         showAlert("Order Fail", "No Orders")
         performSegue(withIdentifier: "OrderViewController", sender: selectedMenus)
        
        // viewModel.totalPrice += 100
//        viewModel.totalPrice.onNext(100)
        
//        viewModel.menuObservable.onNext([
//            Menu(name: "Test", price: 100, count: 2)
//        ])
//        viewModel.menus.append(Menu(name: "Test", price: 100, count: Int.random(in: 0...3)))
//        viewModel.menuObservable.onNext(viewModel.menus)
    }
    
//    func updateUI() {
//        itemCountLabel.text = "\(viewModel.itemsCount)"
////        totalPrice.text = viewModel.totalPrice.currencyKR()
//    }
}

//extension MenuViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as! MenuItemTableViewCell
//
//        let menu = viewModel.menus[indexPath.row]
//
//        cell.title.text = menu.name
//        cell.price.text = "\(menu.price)"
//        cell.count.text = "\(menu.count)"
//
//        return cell
//    }
//}
