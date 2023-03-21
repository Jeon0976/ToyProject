//
//  CalenderViewController.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/20.
//

import UIKit

import RxSwift
import RxCocoa

final class CalenderViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: CalenderViewModel) {

    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
    }
}
