//
//  LongtermViewController.swift
//  ToDoList
//
//  Created by 전성훈 on 2023/03/23.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class LongtermViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: LongtermViewModel) {

    }
    
    private func attribute() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "프로젝트"
    }
    
    private func layout() {
        
    }
}
